
import 'dart:convert';


import 'package:back_nw/Utils/NetworkUtils.dart';

import 'package:http/http.dart'as http;
Future signIn(phone,password,devid,context) async {
  final String url = NetworkUtils.login;
  print(devid);
  final responseFollow = await http.post(url, body: {
    "user_phone":phone,
    "user_password":password,
    "device_id":devid,
  });
  if(responseFollow.statusCode==200) {
    var dataUser = json.decode(responseFollow.body);
    print(dataUser);
    return dataUser;
  }
  else return null;
}

Future signupp(uname,phone,mail,password,devid,context) async {
  print(devid);
  final String url = NetworkUtils.new_register;
  print(url);
  final responseFollow = await http.post(url, body: {
    "user_password":password.toString(),
    "device_id":devid.toString(),
    "user_name":uname.toString(),
    "user_email":mail.toString(),
    "user_phone":phone.toString(),
  });
  print(responseFollow.statusCode);
  if(responseFollow.statusCode==200) {
    var dataUser = json.decode(responseFollow.body);
    return dataUser;
  }
}