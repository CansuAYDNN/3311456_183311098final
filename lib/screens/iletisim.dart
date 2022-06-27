import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';

class iletisim extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _iletisimState();
}

class _iletisimState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İletişim"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: <Color>[Colors.blueAccent, Colors.blueGrey]),
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bg4img.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  title: Text(
                    "mobilmuhasebe@info.net",
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  title: Text(
                    "+99 555 555 55 55",
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.add_location,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  title: Text(
                    "Konya/Selçuklu Bosna Hersek Mh.",
                    style: TextStyle(fontSize: 21),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
