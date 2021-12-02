import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logintest/modal/api.dart';
import 'package:logintest/modal/produkModel.dart';
import 'package:http/http.dart' as http;

class EditProduk extends StatefulWidget {
  final ProdukModel model;
  final VoidCallback reload;

  EditProduk(this.model, this.reload);

  @override
  _EditProdukState createState() => _EditProdukState();
}

class _EditProdukState extends State<EditProduk> {
  final _key = new GlobalKey<FormState>();
  String? namaProduk, qty, harga, desProduk;

  TextEditingController? txtNama, txtQty, txtHarga, txtdesProduk;

  setup() {
    txtNama = TextEditingController(text: widget.model.namaProduk);
    txtQty = TextEditingController(text: widget.model.qty);
    txtHarga = TextEditingController(text: widget.model.harga);
    txtdesProduk = TextEditingController(text: widget.model.desProduk);
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    final response = await http.post(Uri.parse(BaseUrl.editProduk), body: {
      "namaProduk": namaProduk,
      "qty": qty,
      "desProduk": desProduk,
      "harga": harga,
      "idProduk": widget.model.id
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      print(pesan);
      setState(() {
        widget.reload();
        Navigator.pop(context);
      });
    } else {
      print(pesan);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
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
              TextFormField(
                controller: txtNama,
                onSaved: (e) => namaProduk = e,
                decoration: InputDecoration(labelText: 'Nama Produk'),
              ),
              TextFormField(
                controller: txtQty,
                onSaved: (e) => qty = e,
                decoration: InputDecoration(labelText: 'Qty'),
              ),
              TextFormField(
                controller: txtHarga,
                onSaved: (e) => harga = e,
                decoration: InputDecoration(labelText: 'Harga'),
              ),
              TextFormField(
                minLines:
                    1, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: txtdesProduk,
                onSaved: (e) => desProduk = e,
                decoration: InputDecoration(labelText: 'Deskripsi Produk'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
                onPressed: () {
                  check();
                },
                child: Text("Simpan"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
