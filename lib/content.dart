import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Content extends StatefulWidget {
  List list;
  int index;
  Content({this.list, this.index});

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF2E2D4D),
          title: Text(widget.list[widget.index]["titilo"])
        ),
        body: Container(
          height: 800,
          child: mytabs(widget.list[widget.index]["img"], widget.list[widget.index]["descricao"])
        )
      ),
    );
  }
}


Widget mytabs(img, text) {
  return Stack(
    children: <Widget>[
      Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 2)],
            image: DecorationImage(
                image: NetworkImage('http://192.168.1.248/africacult/imgs/' + img),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(.3), BlendMode.darken))),
             ),
      Positioned(
          top: 300,
          left: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)],
            ),
            child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ' ' + text,
                    textAlign: TextAlign.justify,
                  ),
                  RaisedButton(
                    color: Color(0XFF2E2D4D),
                    textColor: Colors.white,
                    child: Text(
                      'Saber mais',
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          )
        )
    ],
  );
}
