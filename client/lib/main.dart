import 'package:flutter/material.dart'; 
import 'package:markus/Screens/account.dart';
import 'package:markus/Screens/home.dart';
import 'package:markus/Screens/login.dart';
import 'package:markus/Screens/menu.dart';
import 'package:markus/Screens/settings.dart';
import 'package:markus/Screens/signin.dart';
import 'package:markus/to_Database/dbMethods.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    DbMethods().initialise();
    return MaterialApp(
      title: 'Markus',
      theme: ThemeData(
        fontFamily: 'Poppins',
        // primarySwatch: Colors.black,
        primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        //https://meet.google.com/xhi-hvvn-rvj
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
