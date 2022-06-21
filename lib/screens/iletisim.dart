import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';

class iletisim extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _iletisimState();
}
class _iletisimState extends State {
  @override
  Widget build (BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("İletişim"),
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