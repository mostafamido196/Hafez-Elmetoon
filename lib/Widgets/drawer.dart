import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final drawerWidth;
  final closeDrawer;
  final gotoAddScreen;
  const DrawerWidget({super.key, required this.drawerWidth, required  this.closeDrawer, required  this.gotoAddScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: drawerWidth,
      color: Theme.of(context).canvasColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('الرئيسية'),
            onTap: closeDrawer

          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('إضافة'),
            onTap: () {
              gotoAddScreen();
            },
          ),
        ],
      ),
    );
  }
}
