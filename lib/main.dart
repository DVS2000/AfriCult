import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'splash.dart';
import 'login.dart';
import 'newuser.dart';
import 'profile.dart';
import 'content.dart';

void main()=> runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Create',
    theme: ThemeData(
      primarySwatch: Colors.purple
    ),
    routes: routes,
    home: MyApp(),

  )
);

final routes = <String, WidgetBuilder> {
    '/splash'   :(BuildContext context) => Splash(),
    '/home'     :(BuildContext context) => Home(),
    '/login'    :(BuildContext context) => Login(),
    '/newuser'  :(BuildContext context) => Newuser(),

  
};

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
   SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Login();
  }
}