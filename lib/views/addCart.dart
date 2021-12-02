
import 'package:flutter/material.dart';

class AddCart extends StatefulWidget {
  const AddCart({ Key? key }) : super(key: key);

  @override
  _AddCartState createState() => _AddCartState();
}

class _AddCartState extends State<AddCart> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text("Users"),
          ),
        ));
  }
}