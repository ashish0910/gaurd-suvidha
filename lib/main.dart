import 'package:flutter/material.dart';
import 'package:gaurd/pages/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "sunshine suvidha",
      theme: new ThemeData(
        primaryColor: new Color(0xFF5424eb),
      ),
      debugShowCheckedModeBanner: false,
      home: new Home(),
    );
  }
}

