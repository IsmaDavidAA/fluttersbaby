import 'package:flutter/material.dart';
import 'package:fluttersbaby/src/Widget_Elements/Box_List_date.dart';
//import 'package:fluttersbaby/src/Widget_Elements/prueba.dart';
import 'package:fluttersbaby/src/Widget_Elements/prueba_de_menu.dart';
import 'package:fluttersbaby/src/pages/home_page.dart';
import 'package:fluttersbaby/src/sidebar/sidebar_layout.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white
      ),
      home: SideBarLayout(),
    );
  }


/*
  //1
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuDashboardPage(),
    );
  }
  //2
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'okay uwu',
      color: Colors.white,

      home: Container(
          width: 300,
          height: 300,
          color: Colors.white,
          child: Align(
            heightFactor: 200,
            widthFactor: 200,

            child: Boxes(),
          ),
        ),
    );
  }*/

}
