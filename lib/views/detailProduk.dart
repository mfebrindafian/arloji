import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logintest/modal/produkModel.dart';

class DetailProduk extends StatefulWidget {
  final ProdukModel model;
  DetailProduk(this.model);
  @override
  _DetailProdukState createState() => _DetailProdukState();
}

class _DetailProdukState extends State<DetailProduk> {
  final money = NumberFormat("#,##0", "en_US");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.yellow,
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              expandedHeight: 400.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                    tag: widget.model.id,
                    child: Image.network(
                      'http://192.168.1.2/login/upload/' + widget.model.image,
                      fit: BoxFit.cover,
                    )),
              ),
            )
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover),
          ),
          child: Card(
            child: Stack(
              children: [
                Positioned(
                    top: 10.0,
                    left: 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.model.namaProduk,
                          style: TextStyle(
                              fontSize: 44.0, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 10, left: 6),
                            child: Text(widget.model.desProduk)),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Card(
                              color: Colors.lightGreen,
                              child: Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(
                                    "Stok :" + widget.model.qty,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                        Card(
                          color: Colors.orange,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              "Harga : Rp. " +
                                  money.format(int.parse(widget.model.harga)),
                            ),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  bottom: 10.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Material(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10.0),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            "Detail Produk",
                            style: TextStyle(color: Colors.black),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
