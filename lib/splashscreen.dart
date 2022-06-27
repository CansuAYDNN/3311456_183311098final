import 'package:flutter/material.dart';
import 'package:mobil_muhasebe/login_page.dart';

void main() {
  runApp(MaterialApp(home: splashscreen()));
}

class splashscreen extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 2),
      () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return ScaleTransition(
                scale: animation,
                alignment: Alignment.centerRight,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return LoginPage();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg4img.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          padding: const EdgeInsets.all(60.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Mobil Muhasebe",
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/LogoMavi.png"),
            ),
          ),
        ),
      ),
    );
  }
}
