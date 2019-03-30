import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class Notifications extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notifications> {

  List<Notificacao> news = [
    Notificacao('Autorizado', 'A sua publicação foi autorizada pelo administrador', 'hoje'),
    Notificacao('Autorizado', 'A sua publicação foi autorizada pelo administrador', '28-03-2019'),
    Notificacao('Autorizado', 'A sua publicação foi autorizada pelo administrador', '24-03-219'),
    Notificacao('Autorizado', 'A sua publicação foi autorizada pelo administrador', '21-03-2019')
  ];

  Widget mylist() {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Slidable(
            delegate:SlidableDrawerDelegate(),
            actionExtentRatio: 0.25,
            child: Column(
              children: <Widget>[
                 ListTile(
              leading: Icon(Icons.notifications),
              title: Text(news[index].title),
              subtitle: Text(news[index].content),
              trailing: Text(news[index].data),
                ),
                Divider()   
              ],
            ),
            actions: <Widget>[
              IconSlideAction(
                caption: 'Eliminar',
                icon: Icons.delete,
                color: Colors.red,
                foregroundColor: Colors.white,
                onTap: () {
                  print('Angola');
                },
              )
            ],
          );
        },
      );
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0XFF2E2D4D),
        title: Text('Notifcação'),
      ),
      body: mylist()
    );
  }
}

class Notificacao {
  String title, content, data;

  Notificacao(this.title, this.content, this.data);
}