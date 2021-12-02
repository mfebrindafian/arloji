// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:logintest/custom/currency.dart';
import 'package:logintest/modal/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class TambahProduk extends StatefulWidget {
  final VoidCallback reload;
  TambahProduk(this.reload);

  @override
  _TambahProdukState createState() => _TambahProdukState();
}

class _TambahProdukState extends State<TambahProduk> {
  String? namaProduk, qty, harga, idUsers, desProduk;
  final _key = new GlobalKey<FormState>();

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      idUsers = preferences.getString("id");
    });
  }

  File? imageFile;
  _pilihGallery() async {
    imageFile = File(await ImagePicker()
        .getImage(
          source: ImageSource.gallery,
          maxHeight: 1920.0,
          maxWidth: 1080.0,
        )
        .then((pickedFile) => pickedFile!.path));
    setState(() {
      imageFile;
    });
  }

  _pilihKamera() async {
    imageFile = File(await ImagePicker()
        .getImage(
          source: ImageSource.camera,
          maxHeight: 1920.0,
          maxWidth: 1080.0,
        )
        .then((pickedFile) => pickedFile!.path));
    setState(() {
      imageFile;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      submit();
    }
  }

  submit() async {
    try {
      var stream =
          http.ByteStream(DelegatingStream.typed(imageFile!.openRead()));
      var length = await imageFile!.length();
      var uri = Uri.parse(BaseUrl.tambahProduk);
      var request = http.MultipartRequest("POST", uri);
      request.fields['namaProduk'] = namaProduk!;
      request.fields['qty'] = qty!;
      request.fields['desProduk'] = desProduk!;
      request.fields['harga'] = harga!.replaceAll(",", '');
      request.fields['idUsers'] = idUsers!;

      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(imageFile!.path)));
      var response = await request.send();
      if (response.statusCode > 2) {
        print("image upload");
        setState(() {
          widget.reload();
          Navigator.pop(context);
        });
      } else {
        print("image failed");
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    var placeholder = Container(
      width: double.infinity,
      height: 150.0,
      child: Image.asset('assets/images/placeholder.png'),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 150.0,
                child: InkWell(
                  onTap: () {
                    _pilihGallery();
                  },
                  child: imageFile == null
                      ? placeholder
                      : Image.file(
                          imageFile!,
                          fit: BoxFit.fill,
                        ),
                ),
              ),
              TextFormField(
                onSaved: (e) => namaProduk = e,
                decoration: InputDecoration(labelText: 'Nama Produk'),
              ),
              TextFormField(
                onSaved: (e) => qty = e,
                decoration: InputDecoration(labelText: 'Jumlah'),
              ),
              TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  CurrencyFormat()
                ],
                onSaved: (e) => harga = e,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
              TextFormField(
                minLines:
                    1, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onSaved: (e) => desProduk = e,
                decoration: InputDecoration(labelText: 'Deskripsi Produk'),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: () {
                    check();
                  },
                  child: Text("Simpan"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
