import 'package:flutter/material.dart';

class LogoApp extends StatelessWidget {
  final double height;
  final double width;

  const LogoApp({this.height = 200, this.width = 200});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.white)],
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/ic_launcher.png'),
        ),
      ),
    );
  }
}
