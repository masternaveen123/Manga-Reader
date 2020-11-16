import 'package:flutter/material.dart';
import 'package:mangareader/screens/homePage.dart';
import 'package:mangareader/services/providerClass.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.red.shade300,
        accentColor: Colors.redAccent,
        scaffoldBackgroundColor: Colors.red.shade300,
        iconTheme: IconThemeData(color: Colors.black87),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
          ),
          bodyText1: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: HomePage(),
      ),
    );
  }
}
