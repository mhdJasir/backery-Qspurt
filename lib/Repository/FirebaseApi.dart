
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';

String deviceid;
Future addToCart(varient_id,product_id,quantity,unit,mrp,price,image,name) async {
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  var androidDeviceinfo = await deviceInfoPlugin.androidInfo;
  deviceid = await androidDeviceinfo.id;
 var rslt = "WORKING";
  await  FirebaseFirestore.instance.collection("cartopen").doc(deviceid).collection(deviceid).doc(varient_id).set(
      {
        "varient_id":varient_id,
        "product_id":product_id,
        "quantity": quantity,
        "unit": unit,
        "base_mrp": mrp,
        "base_price":  price,
        "varient_image":  image,
        "product_varient_name":  name


      }

  ) .then((value){
    rslt ="SUCCESS";
  })
      .catchError((error) {
    rslt ="FAILURE";


  });

    return rslt ;
}

Future CartValueUpdate(varient_id,qty) async{
  var rslt = "WORKING";
  await  FirebaseFirestore.instance.collection("cartopen").doc(deviceid).collection(deviceid).doc(varient_id).update(
      {
        // "id": uid.toString(),

        "quantity": int.parse(qty.toString()),



      }

  ) .then((value){
    rslt ="SUCCESS";
    //Navigator.of(context).pop();
  })
      .catchError((error) {
    rslt ="FAILURE";


  });

  return rslt ;
}

Future DeleteCart(varient_id) async{
  var rslt = "WORKING";
  await  FirebaseFirestore.instance.collection("cartopen").doc(deviceid).collection(deviceid).doc(varient_id).delete().then((value){
    rslt ="SUCCESS";
  })
      .catchError((error) {
    rslt ="FAILURE";


  });

  return rslt ;
}



