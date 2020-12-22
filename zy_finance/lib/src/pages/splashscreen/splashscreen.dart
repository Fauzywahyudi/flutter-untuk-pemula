import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zy_finance/src/config/router.gr.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 4),
      () => Router.navigator.pushReplacementNamed(Router.homePage),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text('SplashScreen'),
          ],
        ),
      ),
    );
  }
}
