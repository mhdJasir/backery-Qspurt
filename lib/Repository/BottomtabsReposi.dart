import 'dart:convert';



import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:http/http.dart'as http;

Future pndingodr(uid)async{
  print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
  final String url = NetworkUtils.pendingordr;
  print("URLlll "+url);
  final response = await http.post(url, body: {
  "user_id" : uid.toString(),
  });
  var ordrpnding = json.decode(response.body);
  print("qwqwqwqwqwqwqwqwqwq"  +ordrpnding.toString() );
  return ordrpnding;
}
Future pstorder(uid)async{
  print("PPPPPPPPPPPPPPPPAAAAAAAAAAA");
  final String url = NetworkUtils.postordr;
  print("BBURL "+url);
  final response = await http.post(url, body: {
    "user_id" : uid.toString(),
  });
  var ordrpnding = json.decode(response.body);
  print("BBBBBBBBBBBBBBB"  +ordrpnding.toString() );
  return ordrpnding;
}