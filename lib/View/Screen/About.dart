
import 'package:back_nw/Controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends StateMVC<About> {
  HomeController _con;
  _AboutState() : super(HomeController()) {
    _con = controller;}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _con.aboutus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:_con.abouttt.toString().isNotEmpty? Text(_con.abouttt.toString()):Text("")
      ),
    );
  }
}
