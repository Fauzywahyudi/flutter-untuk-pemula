import 'package:flutter/material.dart';

class AppNameWhite extends StatelessWidget {
  final double fontSize;

  const AppNameWhite({this.fontSize = 35});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Zy Finance',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        fontFamily: 'McLaren',
      ),
    );
  }
}
