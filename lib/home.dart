import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/services.dart';
import 'search.dart';
import 'intro.dart';
import 'notification.dart';

class Home extends StatefulWidget {
  List list;
  int index;
  Home({this.list, this.index});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  with SingleTickerProviderStateMixin{
  
  TabController _controller;
  int _index = 0;

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this, initialIndex: 0);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        controller: _controller,
        children: <Widget>[
          Intro(list: widget.list, index: 0,),
          Search(),
          Notifications()
        ],
      ),
      bottomNavigationBar: FancyBottomNavigation(
        initialSelection: _index,
        onTabChangedListener: (index) {
            setState(() {
              _index = index;
              _controller.animateTo(_index); 
            });
        },
        tabs: [
          TabData(iconData: Icons.home, title: 'Página inicial'),
          TabData(iconData: Icons.search, title: 'Pesquisar'),
          TabData(iconData: Icons.notifications, title: 'Notificação')
        ],
      ),
    );
  }
}