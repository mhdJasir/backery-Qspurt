

import 'dart:convert';


import 'package:back_nw/Functions/location.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;


Future getBannerList()async{
  final String url = NetworkUtils.bannerlist;
  final response = await http.get(Uri.encodeFull(url));
  var data = json.decode(response.body);
  return data;
}

Future allprod()async{
  final String url = NetworkUtils.allproduct;
  final response = await http.get(Uri.encodeFull(url));
  var allpr = json.decode(response.body);
  return allpr;
}
Future trmconditn()async{
  final String url = NetworkUtils.termcondtn;
  final response = await http.get(Uri.encodeFull(url));
  var temss = json.decode(response.body);
  return temss;
}
Future aboutus()async{
  final String url = NetworkUtils.aboutus;
  final response = await http.get(Uri.encodeFull(url));
  var about = json.decode(response.body);
  print("Abouttt"+about.toString());
  return about;
}



