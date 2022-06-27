import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';

class duzensiz_gider extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _duzensizgiderState();
}
class _duzensizgiderState extends State {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Düzensiz Gider"),
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