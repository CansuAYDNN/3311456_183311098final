import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';

class duzenli_gider extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _duzenligiderState();
}
class _duzenligiderState extends State {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Düzenli Gider"),
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