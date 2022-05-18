

import 'package:back_nw/Controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class TermConditn extends StatefulWidget {
  @override
  _TermConditnState createState() => _TermConditnState();
}

class _TermConditnState extends StateMVC<TermConditn> {
  HomeController _con;
  _TermConditnState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.termconditn();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _con.termm.toString().isEmpty ? Text(" "):Text(_con.termm.toString()),
      ),
    );
  }
}
