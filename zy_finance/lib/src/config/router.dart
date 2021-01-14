import 'package:auto_route/auto_route_annotations.dart';
import 'package:zy_finance/src/pages/home/home_page.dart';
import 'package:zy_finance/src/pages/login_page.dart';
import 'package:zy_finance/src/pages/register_page.dart';
import 'package:zy_finance/src/pages/splashscreen.dart';

@autoRouter
class $Routes {
  @initial
  SplashScreen splashScreen;
  HomePage homePage;
  LoginPage loginPage;
  RegisterPage registerPage;
}
