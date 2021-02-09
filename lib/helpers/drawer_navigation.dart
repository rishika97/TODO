import 'package:TODO/screens/categories_screen.dart';
import 'package:TODO/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('Todo'),
              accountEmail: Text('Category & Priority Based Todo App'),
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
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new HomeScreen()));
              },
            ),
            ListTile(
              title: Text('Categories'),
              leading: Icon(Icons.view_list),
              onTap: (){
                Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new CategoriesScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
