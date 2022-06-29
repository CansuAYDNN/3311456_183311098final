import 'package:flutter/material.dart';

class weathertile extends StatelessWidget{
  IconData icon;
  String title;
  String subtitle;

  weathertile({required this.icon , required this.title, required this.subtitle}) {
  }

  @override
  Widget build (BuildContext context){
    return  ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: Colors.blue[700],)
        ],
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.w600,
            color: Colors.blueAccent[300]
        ),
      ),
    );
  }
}