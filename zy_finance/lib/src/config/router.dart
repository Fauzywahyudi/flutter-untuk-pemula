import 'package:auto_route/auto_route_annotations.dart';
import 'package:zy_finance/src/pages/home/home_page.dart';
import 'package:zy_finance/src/pages/splashscreen/splashscreen.dart';

@autoRouter
class $Router {
  @initial
  SplashScreen splashScreen;
  HomePage homePage;
}
