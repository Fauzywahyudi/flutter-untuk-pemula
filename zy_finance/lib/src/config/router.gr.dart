// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:zy_finance/src/pages/splashscreen/splashscreen.dart';
import 'package:zy_finance/src/pages/home/home_page.dart';

class Router {
  static const splashScreen = '/';
  static const homePage = '/home-page';
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case Router.homePage:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
