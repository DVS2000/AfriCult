import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  List list;
  int index;
  Profile({this.list, this.index});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  // CAMPOS DO USER
  TextEditingController txtNome;             
  TextEditingController txtNumber;          
  TextEditingController txtEmail;
  TextEditingController txtSenhaOld            = TextEditingController();
  TextEditingController txtSenhaNew           = TextEditingController();

  void addUser() {
    final url = "http://192.168.1.248/africacult/user/edituser.php";
    http.post(url, body: {
      "id"        :widget.list[widget.index]["id"],
      "nome"      :txtNome.text.trim(),
      "telefone"  :txtNumber.text.trim(),
      "email"     :txtEmail.text.trim(),
      "senha"     :txtSenhaNew.text.trim()
    });
  }

 // FUNCAO PARA VERIFICAR SE JA EXISTE O USER
 var data;
 Future<List> verifyUser() async {
   final response = await http.get("http://192.168.1.248/africacult/user/getuser.php?telefone=${txtNumber.text.trim()}&senha=${txtSenhaOld.text.trim()}");

   setState(() {
    data = json.decode(response.body);

    if (data.toString() != '[]') {
      openSnackbar('Já existe uma conta com esse número ou email');
      return;
    } else {
       verifySenha();
    }
   });
 }

 // FUNCAO PARA VERIFICAR A SENHA ATINGA
 var dados;
 Future<List> verifySenha() async {
   final response = await http.get("http://192.168.1.248/africacult/user/verifysenha.php?id=${widget.list[widget.index]["id"]}&senha=${txtSenhaOld.text.trim()}");

   setState(() {
    data = json.decode(response.body);

    if (data.toString() != '[]') {
      openSnackbar('Já existe uma conta com esse número ou email');
      return;
    } else {
       addUser();
        Navigator.pop(context);
    }
   });
 }

  // VALIDACAO DOS CAMPOS
  void validation() {
    if (txtNome.text.trim() == "" || txtNumber.text.trim() == "" || txtEmail.text.trim() == "" || txtSenhaOld.text.trim() == "" || txtSenhaNew.text.trim() == "") {
      openSnackbar('Deve preencher todos os campos');
      return;

    } else {
       verifySenha();
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
  void initState() {
   txtNome      =TextEditingController(text: widget.list[widget.index]["nome"]);
   txtNumber    =TextEditingController(text: widget.list[widget.index]["telefone"]);
   txtEmail     =TextEditingController(text: widget.list[widget.index]["email"]);
    super.initState();
  }

  void openAlert() {
    AlertDialog alert =AlertDialog(
      content: SingleChildScrollView(
          child: Container(
          height: 280,
          child: Column(
            children: <Widget>[
              TextField(
                controller: txtNome,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Nome'
                ),
              ),
               TextField(
                 controller: txtNumber,
                 keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  hintText: 'Telefone'
                ),
              ),
              TextField(
                controller: txtEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Email'
                ),
              ),
              TextField(
                controller: txtSenhaOld,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Senha antiga'
                ),
              ),
              TextField(
                controller: txtSenhaNew,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: 'Nova senha'
                ),
                )

            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: (){
            validation();
          },
        ),
        FlatButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, child: alert);
  }
  @override
  Widget build(BuildContext context) {
    final width  = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        backgroundColor: Color(0XFF2E2B48),
        title: Text(widget.list[widget.index]["nome"]),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: (){
              openAlert();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
              child: Stack(
          children: <Widget>[
            Container(
              height: 300,
              width: width,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 bottomLeft: Radius.circular(10),
                 bottomRight: Radius.circular(10),
               ),
               boxShadow: [
                 BoxShadow(
                   color: Colors.black38,
                   blurRadius: 4
                 )
               ],
               image: DecorationImage(
                 image: NetworkImage('http://192.168.1.248/africacult/imgs/' + widget.list[widget.index]["img"]),
                 fit: BoxFit.cover
               )
             ),
            ),
             Container(
               margin: const EdgeInsets.only(top: 280, left: 10, right: 10),
               height: 350, 
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.circular(10),
                 boxShadow: [
                   BoxShadow(
                     color: Colors.black38,
                     blurRadius: 3
                   )
                 ]
               ),
            child: Column(
              children: <Widget>[
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: <Widget>[
                      Container(
                        constraints: BoxConstraints.expand(height: 50,),
                        child: TabBar(
                          labelColor: Color(0XFF2E2B48),
                          tabs: <Widget>[
                            Tab(text: 'Sobre min',),
                            Tab(text: 'Minhas publicação',)
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        height: 280,
                       child: TabBarView(
                         children: <Widget>[
                           Container(child: aboutMe(),),
                           Container(child: myposts(),)
                         ],
                       ),
                      )
                    ],
                  ),
                )
              ],
            ),
            ),
           
          ],
        ),
      ),
    );
  }

  Widget aboutMe() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.person),
          title: Text(widget.list[widget.index]["nome"]),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text(widget.list[widget.index]["telefone"]),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.email),
          title: Text(widget.list[widget.index]["email"]),
        )
      ],
    );
  }

   Widget myposts() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.local_post_office),
          title: Text('Novas paisagens africas'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.local_post_office),
          title: Text('Novos trajes africano'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.local_post_office),
          title: Text('Srgimento de novos pratos africano'),
        )
      ],
    );
  }
}