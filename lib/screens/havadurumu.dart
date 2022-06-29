
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/Widget/myDrawe.dart';
import 'package:mobil_muhasebe/Widget/main_widget.dart';

Future<WeatherInfo> fetchWeather() async {
  final zipCode = "42250";
  final apiKey = "3644842938f2514fdf312d528cedaaf1";
  final requestUrl = "https://api.openweathermap.org/data/2.5/weather?zip=${zipCode},tr&units=imperial&appid=${apiKey}";
  final response = await http.get(Uri.parse(requestUrl));

  if (response.statusCode == 200) {
    return WeatherInfo.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Error Loading request URl info.");
  }
}

class WeatherInfo{
  final String location;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String weather;
  final int humidity;
  final double windspeed;




  WeatherInfo({
    required this.location,
    required this.temp,
    required this.humidity,
    required this.tempMax,
    required this.tempMin,
    required this.weather,
    required this.windspeed

  });


  factory WeatherInfo.fromJson(Map<String , dynamic >json){
    return WeatherInfo(
      location: json['name'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      weather: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windspeed: json['wind']['speed'],
    );
  }
}

class havadurumu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _havadurumuState();
  }
}

class _havadurumuState extends State<havadurumu> {
  late Future<WeatherInfo> futureWeather;
  @override
  void initState(){
    super.initState();
    futureWeather= fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Hava Durumu"),
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
        body: FutureBuilder<WeatherInfo>(
            future: futureWeather,
            builder: (context, snapshot)  {
              if(snapshot.hasData) {
                return MainWidget(
                  location:  snapshot.data!.location,
                  temp: snapshot.data!.temp,
                  tempMin: snapshot.data!.tempMin,
                  tempMax: snapshot.data!.tempMax,
                  weather: snapshot.data!.weather,
                  humidity: snapshot.data!.humidity,
                  windspeed: snapshot.data!.windspeed,
                );
              }else if (snapshot.hasError) {
                return Center(
                  child:  Text("${snapshot.error}"),
                );
              }
              return CircularProgressIndicator();
            }
        )
    );
  }
}
