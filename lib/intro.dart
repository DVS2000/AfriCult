import 'dart:convert';

import 'package:AFRICULT/content.dart';
import 'package:AFRICULT/login.dart';
import 'package:AFRICULT/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Intro extends StatefulWidget {
  List list;
  int index;

  Intro({this.list, this.index});
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {

    List dados;
    // GET ALL NEWS
    Future<List> getData() async {
      final response = await http.get('http://192.168.1.248/africacult/noticia/getall.php');
      dados =json.decode(response.body);
      return json.decode(response.body);
    }

    GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();

    void openDrawe() {
      _scaffoldState.currentState.openDrawer();
    }

    String urlimg = "http://192.168.1248/fricacult/imgs/quenia.jpg";
    List list;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldState,
      drawer: mydrawer(height),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getData(),
        builder: (context, ss) {
          if (ss.hasData) {
              
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  'http://192.168.1.248/africa/img/africa.jpg',
                  fit:BoxFit.cover,
                  height: 300,
                  width: width,
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black.withOpacity(.3),

                ),
                Positioned(
                  top: 10,
                  child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white,),
                    onPressed: () {
                      openDrawe();
                    },
                  ),
                ),
                SizedBox(
                  height: 370,
                  child: Center(
                    child: Text(
                      'Culturas Africana',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                      ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 250),
                  padding: const EdgeInsets.only(left:40, right: 40, top: 20, bottom: 20),
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Sobre africa',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 6,),
                      Text('A África é o terceiro continente mais extenso (depois da Ásia e da América) com cerca de 30 milhões de quilômetros quadrados.',
                      textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ],
            ),
             Container(
               margin: const EdgeInsets.only(left: 40, right: 10),
               child: Text(
               'Em destaque',
                style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
                ),
               ),
             ),

            Container(
              height: 270,
              child: ListView.builder(
              itemCount: 6,

              itemBuilder: (context, index) {              
                return Container(
                  width: width,
                  child: FlatButton(
                    child: mycard(ss.data[index]["img"],ss.data[index]["titilo"], ss.data[index]["descricao"], width),
                    onPressed: (){
                       Navigator.of(context).push(
                         MaterialPageRoute(
                           builder: (context) => Content(list: dados, index: index),
                         )
                       );
                    },
                  ),
                );
              },
            ),
            )

          ],
        );
          } else {
              return Center(
                child:CircularProgressIndicator()
              );
          }
        }
      ),
    );
  }

  Widget mydrawer(height) {
  List<String> options = [
    'Minha conta',
    'Paisagem',
    'Vestuário',
    'Culinária',
    'Sair'
  ];

  List<IconData> icons = [
    Icons.person,
    Icons.picture_in_picture,
    Icons.person,
    Icons.cake,
    Icons.exit_to_app
  ];
  return Container(
    width: 300,
    height: height,
    color: Colors.white,
    child: Column(
      children: <Widget>[
       Image.network(
         'http://192.168.1.248/africa/img/icon.png',
         fit:BoxFit.cover,
         height: 250,
         width: 300,
         color: Colors.black.withOpacity(.2),
         colorBlendMode: BlendMode.darken,
       ),
       Container(
         height: 300,
         child: ListView.builder(
           itemCount: options.length,
           itemBuilder: (context, index) {
             return ListTile(
               title: Text(options[index]),
               trailing: Icon(icons[index]),
               onTap:() {
                 switch (index) {
                   case 0:
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context) => Profile(list: widget.list, index: 0,)
                       )
                     );
                     break;

                     case 4:
                     Navigator.of(context).push(
                       MaterialPageRoute(
                         builder: (context) => Login()
                       )
                     );
                     break;
                   default:
                 }
               },
             );
           },
         ),
       )
      ],
    ),
  );
}
}



Widget mycard(String img, String title, String content, double width) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2
          )
        ]
       ),
       child: Row(
         children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10)
              ),
              image: DecorationImage(
                image: NetworkImage('http://192.168.1.248/africacult/imgs/' + img),
                fit: BoxFit.cover
              )
            ),
            ),
           Container(
             width: 210,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 SizedBox(height: 10,),
                 Text(
                   title,
                   style: TextStyle(
                     fontSize: 20,
                     fontWeight: FontWeight.w600
                   ),
                 ),
                Text(
                   content,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                   textAlign: TextAlign.justify,
                 ),
                
               ],
             ),
           )
         ],
       ),
  );
}




class News {
  String img, title, content;

  News(this.img, this.title, this.content);
}