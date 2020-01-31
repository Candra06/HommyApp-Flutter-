import 'package:flutter/material.dart';
import 'package:hommy_app/Splash.dart';

void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new SplashScreen(),
    );
  }
}