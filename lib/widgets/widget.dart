import 'dart:ui';

import 'package:flutter/material.dart';
Widget BrandName() {
  return Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "taswir",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontFamily: 'fantasy', 
          ),
        ),
        Text(
          "TI",
          style: TextStyle(
            color: Colors.orange[500],
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            fontFamily: 'cursive',
          ),
        ),
      ],
    ),
  );
}
