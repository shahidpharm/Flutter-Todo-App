import 'package:flutter/material.dart';
import 'package:to_do/helpers/drawer_navigation.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do App'),
      ),
      body: Container(),
      drawer: DrawerNavigation(),
    );
  }
}
