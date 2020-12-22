import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zy_finance/src/config/router.gr.dart';
import 'package:zy_finance/src/provider/dark_theme.dart';
import 'package:zy_finance/src/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Router.splashScreen,
            onGenerateRoute: Router.onGenerateRoute,
            navigatorKey: Router.navigatorKey,
            theme: MyTheme.themeData(themeChangeProvider.darkTheme, context),
          );
        },
      ),
    );
  }
}
