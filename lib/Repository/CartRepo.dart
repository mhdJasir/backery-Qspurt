

import 'dart:convert';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../View/GlobalVar.dart';


Future timeslot(date)async{
  final String url = NetworkUtils.timeslot;
  final res = await http.post(url, body: {
    "selected_date":date,
  });
  print(res.statusCode);
  if(res.statusCode==200) {
    var data = json.decode(res.body);
    return data;
  }
  else Fluttertoast.showToast(msg: 'something went wrong');
}

Future addAddress(pin,hous,soct,lndmrk,nam,mob,lat,long,city)async{
  final String url = NetworkUtils.add_address;
  Map<String,String> body= {
    "user_id": USERID,
    "receiver_name": nam,
    "receiver_phone": mob,
    "city_name": city.toString(),
    "society_name": soct.toString(),
    "house_no": hous.toString(),
    "landmark": lndmrk.toString(),
    "state": "kerala",
    "pin": pin.toString(),
    "lat": lat.toString(),
    "lng": long.toString()
  };
  print(body);
  final res = await http.post(url,body: body);
  print(res.statusCode);
  if(res.statusCode==200){
    var data=json.decode(res.body);
    print(data);
    return data;
  }
  else Fluttertoast.showToast(msg: 'something went wrong');
}
Future editAddress(addressId,name,mobileNumber,city,society,house,landMark,pin,lat,lng)async{
  final url="${NetworkUtils.edit_address}";
  Map<String,String> body={
    "address_id": addressId.toString(),
    "user_id": "2",
    "receiver_name":name,
    "receiver_phone":mobileNumber.toString(),
    "city_name":city.toString(),
    "society_name":society.toString(),
    "house_no":house.toString(),
    "landmark":landMark.toString(),
    "state":"kerala",
    "pin":pin.toString(),
    "lat":lat.toString(),
    "lng":lng.toString(),
  };
  print(body);
  final res = await http.post(url,body: body);
  print(res.statusCode);
  if(res.statusCode==200){
    var data=json.decode(res.body);
    print(data);
    return data;
  }
  else Fluttertoast.showToast(msg: 'something went wrong');
}


Future<Map<String, dynamic>> checkoutdataas(pmde,pstts,wallt)async{
  print(pmde);
  final String url = NetworkUtils.checkout;
  final res = await http.post(url, body: {
    "cart_id":"YSJE82d0",
    "payment_method":pmde.toString(),
    "payment_status":pstts.toString(),
    "wallet":wallt.toString(),
  });
  var data = json.decode(res.body);
  return data;
}

Future getAddresses()async{
  final String url = NetworkUtils.show_address;
  final res = await http.post(url, body: {
    "user_id":USERID,
    "store_id":"22",
  });
  if(res.statusCode==200) {
    var data = json.decode(res.body);
    return data;
  }
  else Fluttertoast.showToast(msg: 'something went wrong');
}





