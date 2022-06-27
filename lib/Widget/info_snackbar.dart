import 'package:flutter/material.dart';

SnackBar deleteInfoSnackBar = SnackBar(
  backgroundColor: Colors.green[800],
  duration: Duration(
    seconds: 2,
  ),
  content: Row(
    children: [
      Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      SizedBox(
        width: 6.0,
      ),
      Text(
        "Silmek için basılı tutun.",
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
    ],
  ),
);