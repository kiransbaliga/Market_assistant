import 'package:flutter/material.dart';
import 'package:markus/Screens/account.dart';
import 'package:markus/Screens/home.dart';
import 'package:markus/Screens/login.dart';
import 'package:markus/Screens/menu.dart';
import 'package:markus/Screens/settings.dart';
import 'package:markus/Screens/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markus',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        'home': (context) => HomePage(),
        'settings': (context) => Settings(),
        'account': (context) => Account(),
        'login': (context) => Login(),
        'signin': (context) => Signin(),
      },
      initialRoute: 'home',
    );
  }
}
