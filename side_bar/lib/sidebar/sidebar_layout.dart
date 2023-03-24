import 'package:flutter/material.dart';
import 'package:side_bar/screens/home_page.dart';
import 'package:side_bar/sidebar/sidebar.dart';

class SidebarLayout extends StatefulWidget {
  const SidebarLayout({Key? key}) : super(key: key);

  @override
  _SidebarLayoutState createState() => _SidebarLayoutState();
}

class _SidebarLayoutState extends State<SidebarLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          HomePage(),
          SideBar(),
        ],
      ),
    );
  }
}

