import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'splash.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtPass   = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldState =GlobalKey<ScaffoldState>();

  void openSnackbar(String content) {
    _scaffoldState.currentState.showSnackBar(
      SnackBar(
        content: Row(
          children: <Widget>[
            Text(content),
            Icon(Icons.warning)
          ],
        ),
      )
    );
  }

var data;
 Future<List> login() async{
    final response = await http.get("http://192.168.1.248/africacult/user/getuser.php?telefone=${txtNumber.text.trim()}&senha=${txtPass.text.trim()}");
   setState(() {
     data = json.decode(response.body);
     
     if(data.toString() == '[]') {
       openSnackbar('Os seus dados estão errado');
     } else {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (BuildContext context) => Splash(list: data, index: 0,)
          ),
          (Route<dynamic> route) => false 
        );
     }
   });

  }

  void validation() {
    if (txtNumber.text.trim() == "" || txtPass.text.trim() == "") {
      openSnackbar('Deve preencher todos os campos');
    } else {
      login();
    }
  }



  @override
  Widget build(BuildContext context) {
    final width  = MediaQuery.of(context).size.width;
    final height =MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldState,
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
                      child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage('http://192.168.1.248/africa/img/icon.png',),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Text(
                    'AfriCult',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontFamily: 'Georgia',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 45,
                    width: width / 1.1,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 2
                        )
                      ]
                    ),
                    child: TextField(
                      controller: txtNumber,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Telefone ou Email',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 45,
                    width: width / 1.1,
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          blurRadius: 2
                        )
                      ]
                    ),
                    child: TextField(
                      controller: txtPass,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Senha',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                 Container(
                   width: 200,
                   height: 45,
                   decoration: BoxDecoration(
                     color: Color(0XFF2E2B48),
                     border: Border.all(width: 1, color: Colors.white, style: BorderStyle.solid),
                     borderRadius: BorderRadius.circular(50)
                   ),
                   child: FlatButton(
                     child: Text('Entrar', style: TextStyle(color: Colors.white),),
                     onPressed: () {
                       validation();
                     },
                   ),
                 ),
                 SizedBox(height: 8,),
                 Container(
                   width: 150,
                   height: 45,
                   decoration: BoxDecoration(
                     color: Color(0XFF2E2B48),
                     border: Border.all(width: 1, color: Colors.white, style: BorderStyle.solid),
                     borderRadius: BorderRadius.circular(50)
                   ),
                   child: FlatButton(
                     child: Text('Criar conta', style: TextStyle(color: Colors.white),),
                     onPressed: () {
                       Navigator.of(context).pushNamed('/newuser');
                     },
                   ),
                 )
                ],
              )
            ),
          )
        ],
      ),
     
      
    );
  }
}