import 'dart:ui';
import 'package:AFRICULT/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class Splash extends StatefulWidget {
  List list;
  int index;
  Splash({this.list, this.index});
  
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  void loadHome() {
   Timer(Duration(seconds: 15), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => Home(list: widget.list, index: 0,)
          ),
          (Route<dynamic> route) => false
        );
   });
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
      loadHome();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.network( 'http://192.168.1.248/africa/img/back.jpg', height: MediaQuery.of(context).size.height, fit: BoxFit.cover,),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4,
              sigmaY: 4
            ),
            child: Container(
              color: Colors.white.withOpacity(.0),
            )
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 230,
                  width: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage('http://192.168.1.248/africa/img/icon.png',),
                      fit: BoxFit.cover
                    )
                  ),
                  child: CircularProgressIndicator(),
                ),

                Text(
                  'AfriCult',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                ),
                Text(
                  'Welcome to África',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontFamily: 'Georgia',
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic
                  ),
                ),
               
              ],
            )
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  'Todos direitos reservado @Company 2019 ',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}