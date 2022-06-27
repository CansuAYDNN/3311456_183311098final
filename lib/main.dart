
import 'dart:js';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobil_muhasebe/login_page.dart';
import 'package:mobil_muhasebe/screens/doviz.dart';
import 'package:mobil_muhasebe/screens/duzenli_gelir.dart';
import 'package:mobil_muhasebe/screens/duzensiz_gider.dart';
import 'package:mobil_muhasebe/screens/duzenli_gider.dart';
import 'package:mobil_muhasebe/screens/duzensiz_gelir.dart';
import 'package:mobil_muhasebe/screens/hakkimizda.dart';
import 'package:mobil_muhasebe/screens/havadurumu.dart';
import 'package:mobil_muhasebe/screens/iletisim.dart';
import 'package:mobil_muhasebe/screens/rapor.dart';
import 'package:mobil_muhasebe/screens/vizyonumuz_misyonumuz.dart';
import 'package:mobil_muhasebe/signup_page.dart';
import 'package:mobil_muhasebe/splashscreen.dart';
import 'home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';





 main() async {
   await Hive.initFlutter();
   await Hive.openBox('money');
   await Hive.openBox('yem');
   await Hive.openBox('tohum');

   await Firebase.initializeApp(
       options: FirebaseOptions(

           apiKey: "AIzaSyBpK6mej5CFEbAGgUamZBoPbzusccgYRy4",
           appId: "183311098MobilMuhasebe",
           messagingSenderId: "738328531597",
           projectId: "mobilmuhasebe-947f4")
   );
   runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => splashscreen(),
        "/splashscreen": (context) => splashscreen(),
        "/login_page": (context) => LoginPage(),
        "/havadurumu": (context) => havadurumu(),
        "/home_page": (context) => homepage(),
        "/duzensiz_gider": (context) => duzensiz_gider(),
        "/duzensiz_gelir": (context) => duzensiz_gelir(),
        "/duzenli_gider": (context) => duzenli_gider(),
        /*"/duzenli_gelir": (context) => TransactionPage(), */
        "/hakkimizda": (context) => hakkimizda(),
        "/iletisim": (context) => iletisim(),
        "/rapor": (context) => rapor(),
        "/vizyonumuzmisyonumuz": (context) => vizyonumuz_misyonumuz(),
        "/mainpage": (context) => mainpage(),
        "/signup_page": (context) => SignupPage(),
      },
    ),
  );
 }

class mainpage extends StatefulWidget {
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  int currentIndex = 0;
  final screens = [
    homepage(),
    havadurumu(),
    doviz(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueGrey,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Anasayfa",
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_outlined),
              label: "Hava Durumu",
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: "Döviz",
              backgroundColor: Colors.blueGrey,
            ),
          ],
        ),
      );
}
