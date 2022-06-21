import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/screens/dashboard.dart';
import '../Widget/myDrawe.dart';

class Doviz extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
    );
  }
}

class doviz extends StatefulWidget {

  @override
  _dovizState createState() => _dovizState();
}

class _dovizState extends State<doviz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
      body: DashboardPage(currencyVal: 0.0 ,convertedCurrency: 0.0 ,currencyone: 'USD',currencytwo: 'RUB',isWhite: false,)
    );
  }
}
