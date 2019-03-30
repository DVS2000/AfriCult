import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  
  // GET BY TITULO
  String titlo = "";
  Future<List> getData() async {
    final response =await http.get("http://192.168.1.248/africacult/noticia/search.php?titulo=$titlo");
    return json.decode(response.body);
  }

  List<String> nomes = [
    "Dorivaldo", "Edna"
  ];
  List<News> tests = [
    News('Vestuário', 'Angola é granda bla blaa bla..'),
    News('Comida', 'Angola é granda bla blaa bla..'),
    News('Dança', 'Angola é granda bla blaa bla..'),
    News('Vestuário', 'Angola é granda bla blaa bla..'),
    News('Comida', 'Angola é granda bla blaa bla..'),
    News('Dança', 'Angola é granda bla blaa bla..'),
    News('Vestuário', 'Angola é granda bla blaa bla..'),
    News('Comida', 'Angola é granda bla blaa bla..'),
    ];

    TabController _controller;

    @override
  void initState() {
    // TODO: implement initState
    _controller =  TabController(length: 4, initialIndex: 0, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0XFF2E2D4D),
          title: textSearch(),
          bottom: TabBar(
            
            indicatorColor: Colors.white,
            controller: _controller,
            tabs: <Widget>[
               Tab(text: 'Todas',),
               Tab(text: 'Paisagem',),
               Tab(text: 'Vestuário',),
               Tab(text: 'Colunária',),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
              result(),
             Container(color: Colors.purple, child: RaisedButton(child: Text('Clica'),onPressed: (){print(tests.length);},),),
             Container(color: Colors.orange,),
              Container(color: Colors.red,)
          ],
        )
    
    );
  }

  Widget textSearch() {
  return Container(
    padding: const EdgeInsets.only(left: 16, right: 16,),
    height: 45,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50)
    ),
    child: TextField(
      decoration: InputDecoration(
         hintText: 'Pesquisar',
        suffixIcon: Icon(Icons.search),
        border: InputBorder.none
      ),
    ),
  );
}



Widget result() {
  return Container(
    margin: const EdgeInsets.only(top: 5),
    child: ListView.builder(
      itemCount: tests.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Color(0XFF2E2D4D),
              shape: BoxShape.circle
            ),
            child: Center(
              child: Text(tests[index].title[0], style:TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
          title: Text(tests[index].title),
          subtitle: Text(tests[index].title),
          trailing: Icon(Icons.navigate_next),
        );
      } 
    )
  );
}

}

class Noticia {
  String title, content;

  Noticia(this.title, this.content);
}

class News {
  String title;
  String content;

  News(this.title, this.content);
}