import 'package:flutter/material.dart';
import 'weathertile.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class MainWidget extends StatelessWidget{
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windspeed;

  MainWidget({
    required this.location,
    required this.temp,
    required this.humidity,
    required this.tempMax,
    required this.tempMin,
    required this.weather,
    required this.windspeed
  });

  @override
  Widget build (BuildContext context){
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.purple,
                Colors.pink,
              ]
            )
          ),

          height: MediaQuery.of(context).size.height / 3.2,
          width: MediaQuery.of(context).size.width,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${location.toString()}",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text(
                  "${temp.toInt().toString()}°",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900),
                ),
              ),
              Text(
                "En yüksek ${tempMax.toInt().toString()}° , En düşük ${tempMin.toInt().toString()}°",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: ListView(
              children: [
                weathertile(icon: Icons.thermostat, title: "Sıcaklık", subtitle: "${temp.toInt().toString()} °"),
                weathertile(icon: Icons.filter_drama_outlined, title: "Hava", subtitle: "${weather.toString()}"),
                weathertile(icon: Icons.wb_sunny, title: "Nem", subtitle: "${humidity.toString()}%"),
                weathertile(icon: Icons.waves_outlined, title: "Rüzgar hızı", subtitle: "${windspeed.toString().toString()} kmh"),
              ],
            ),
          ),)
      ],
    );
  }
}