import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zy_finance/src/provider/dark_theme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final stateTheme = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Home Page')),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(title: Text('Home')),
            ListTile(title: Text('Profil')),
            SwitchListTile(
              title: Text('Dark Mode'),
              value: stateTheme.darkTheme,
              onChanged: (value) => stateTheme.darkTheme = value,
            )
          ],
        ),
      ),
      body: Container(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: null,
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
