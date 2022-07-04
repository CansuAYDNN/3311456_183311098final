import 'package:flutter/material.dart';
import 'weathertile.dart';

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
                Colors.white70,
                Colors.blueAccent,
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
                  fontSize: 40.0,
                  fontWeight: FontWeight.w900,
                  color: Colors.white
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Text(
                  "${(temp-273.15).toInt().toString()}°",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                "En Yüksek ${(tempMax-273.15).toInt().toString()}° ,  En Düşük ${(tempMin-273.15).toInt().toString()}°",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
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
                weathertile(icon: Icons.thermostat, title: "Sıcaklık", subtitle: "${(temp-273.15).toInt().toString()} °"),
                weathertile(icon: Icons.filter_drama_outlined, title: "Hava", subtitle: "${weather.toString()}"),
                weathertile(icon: Icons.wb_sunny, title: "Nem", subtitle: "${humidity.toString()}%"),
                weathertile(icon: Icons.waves_outlined, title: "Rüzgar Hızı", subtitle: "${windspeed.toString().toString()} kmh"),
              ],
            ),
          ),)
      ],
    );
  }
}