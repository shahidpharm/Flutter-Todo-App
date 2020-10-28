import 'package:flutter/material.dart';
import 'file:///F:/Personal/Development/Flutter/to_do/lib/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do App',
      home: Home(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
