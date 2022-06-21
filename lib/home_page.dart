import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';
class homepage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _homepageState();
}
class _homepageState extends State {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Anasayfa"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:Alignment.topRight,
                  colors: <Color>[Colors.pink, Colors.deepPurple]
              ),
            ),
          ),
        ),
        drawer: MyDrawer(),
        body:Container(
            child:Center(
              child:Text("aqaaaa"),)
        )
    );
  }
}