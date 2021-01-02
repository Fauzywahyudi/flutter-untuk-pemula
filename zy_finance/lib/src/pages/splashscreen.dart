import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/provider/shared_preferences.dart';

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

  void cekUserState() async {
    final dataShared = DataShared();
    final result = await dataShared.getIsNew();
    if (result == null || !result) {
      Router.navigator.pushReplacementNamed(Router.registerPage);
    } else {
      Router.navigator.pushReplacementNamed(Router.homePage);
    }
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
