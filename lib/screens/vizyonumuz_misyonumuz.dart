import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';

class vizyonumuz_misyonumuz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _vizyonumuzmisyonumuzState();
}
class _vizyonumuzmisyonumuzState extends State {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Vizyonumuz Misyonumuz"),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end:Alignment.topRight,
                  colors: <Color>[Colors.blueAccent, Colors.blueGrey]
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