import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zy_finance/src/config/router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.splashScreen,
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
