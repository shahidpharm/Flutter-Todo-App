import 'package:flutter/material.dart';
import 'package:to_do/screens/categories.dart';
import 'package:to_do/screens/home.dart';

class DrawerNavigation extends StatefulWidget {
  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Shahid'),
              accountEmail: Text('shahidpharm@hotmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: Icon(
                    Icons.filter_list,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home())),
            ),
            ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.view_list),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Categories())),
            ),
          ],
        ),
      ),
    );
  }
}
