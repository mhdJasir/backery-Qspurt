


import 'package:flutter/material.dart';

 moveBack(context,route){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
    return route;
  }));
}

 sbh(double height)=>SizedBox(height: height);
 sbw(double width)=>SizedBox(width: width);

 height(context)=>MediaQuery.of(context).size.height;
 width(context)=>MediaQuery.of(context).size.width;
