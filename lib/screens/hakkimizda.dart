import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';

class hakkimizda extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _hakkimizdaState();
}
class _hakkimizdaState extends State {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hakkımızda"),
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