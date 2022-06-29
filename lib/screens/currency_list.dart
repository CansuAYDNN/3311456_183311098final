import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/screens/dashboard.dart';

import 'dashboard.dart';

class CurrencyList extends StatefulWidget {
  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          getListItem('Rusya Rublesi', 'RUB'),
          getListItem('Hindistan Rupe', 'INR'),
          getListItem('Japonya Yen', 'JPY'),
          getListItem('Pound Sterlin', 'GBP'),
        ],
      ),
    );
  }

  Widget getListItem(String currencyName, String currency) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (context) => DashboardPage(
              currencyVal: 0.0,
              isWhite: false,
              convertedCurrency: 0.0,
              currencyone: 'USD',
              currencytwo: currency,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 25.0, bottom: 20.0),
        child: Text(
          currencyName,
          style: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
