import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'splash.dart';

class Newuser extends StatefulWidget {
  @override
  _NewuserState createState() => _NewuserState();
}

class _NewuserState extends State<Newuser> {

  // CAMPOS DO USER
  TextEditingController txtNome             = TextEditingController();
  TextEditingController txtNumber           = TextEditingController();
  TextEditingController txtEmail            = TextEditingController();
  TextEditingController txtSenha            = TextEditingController();
  TextEditingController txtSenhaConfirmed   = TextEditingController();

  // FUNCAO PARA CADASTRAR NOVO USUARIO
  void addUser() {
    final url = "http://192.168.1.248/africacult/user/adduser.php";
    http.post(url, body: {
      "nome"      :txtNome.text.trim(),
      "telefone"  :txtNumber.text.trim(),
      "email"     :txtEmail.text.trim(),
      "senha"     :txtSenha.text.trim()
    });
  }

 // FUNCAO PARA VERIFICAR SE JA EXISTE O USER
 var data;
 Future<List> verifyUser() async {
   final response = await http.get("http://192.168.1.248/africacult/user/getuser.php?telefone=${txtNumber.text.trim()}&senha=${txtSenha.text.trim()}");

   setState(() {
    data = json.decode(response.body);

    if (data.toString() != '[]') {
      openSnackbar('Já existe uma conta com esse número ou email');
      return;
    } else {
       addUser();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Splash(list: data, index: 0,)
          ), 
        (Route<dynamic> route) => false
        );
    }
   });
 }

  // VALIDACAO DOS CAMPOS
  void validation() {
    if (txtNome.text.trim() == "" || txtNumber.text.trim() == "" || txtEmail.text.trim() == "" || txtSenha.text.trim() == "") {
      openSnackbar('Deve preencher todos os campos');
      return;

    } else if(txtSenha.text.trim() !=txtSenhaConfirmed.text.trim()) {
      openSnackbar('Confirma sua senha novamente');
      } else {
       verifyUser();
    }
  }

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
                      controller: txtNome,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Nome',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        hintText: 'Telefone',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                      controller: txtEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
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
                      controller: txtSenha,
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
                      controller: txtSenhaConfirmed,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Confirma a senha',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                 SizedBox(height: 10,),
                 
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
                       validation();
                     },
                   ),
                 )
                ],
              )
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
              icon: Icon(Icons.arrow_back, color: Color(0XFF2E2B48), size: 30,),
              onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
              },
            ),
            )
          )
        ],
      ),
        
    );
  }
}