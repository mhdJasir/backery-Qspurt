import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

Future httpGet(url,{Map<String, String> header})async{
  var api=Uri.parse(url);
  var response=await http.get(api,headers: header);
  if(response.statusCode==200){
    var data=json.decode(response.body);
    return data;
  }
  else Fluttertoast.showToast(msg: 'Something went wrong');
}

Future<dynamic> httpPost(url,{Map<String, String> header,Object body})async{
  var api=Uri.parse(url);
  var response=await http.post(api,headers: header,body: body);
  print(response.statusCode);
  if(response.statusCode==200){
    var data=json.decode(response.body);
    return data;
  }
  else Fluttertoast.showToast(msg: 'Something went wrong');
}