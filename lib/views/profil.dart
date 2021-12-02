import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 120),
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow()],
                    borderRadius: BorderRadius.circular(150.0),
                    border: Border.all(
                      width: 3, //
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                  child: Text('m. febrin dafian',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold))),
              Center(
                  child: Text('Admin',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: 30.0),
              SizedBox(height: 20.0),
            ])),
          ],
        ),
      ),
    );
  }
}
