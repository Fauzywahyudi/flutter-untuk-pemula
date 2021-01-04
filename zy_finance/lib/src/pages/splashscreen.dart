import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/provider/shared_preferences.dart';
import 'package:zy_finance/src/widget/logo.dart';
import 'package:zy_finance/src/widget/text.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 4),
      () => cekUserState(),
    );
    super.initState();
  }

  void cekUserState() async {
    final dataShared = DataShared();
    final isNew = await dataShared.getIsNew();
    if (isNew == null || isNew) {
      Router.navigator.pushReplacementNamed(Router.registerPage);
    } else {
      final user = await dataShared.getIdUser();
      if (user != null || user != 0)
        Router.navigator.pushReplacementNamed(Router.homePage);
      else
        Router.navigator.pushReplacementNamed(Router.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        width: size.width,
        height: size.height,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoApp(),
              SizedBox(height: 50),
              AppNameWhite(),
            ],
          ),
        ),
      ),
    );
  }
}
