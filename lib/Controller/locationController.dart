
import 'dart:math';
import 'package:get/get.dart';

class LocationController extends GetxController{

var latCalicut=11.2588;
var lngCalicut=75.7804;

 Future<bool> isServiceable(lat,lng)async{
    //var distance= Geolocator.distanceBetween(latCalicut, lngCalicut, location.latitude, location.longitude);
    var distance= calculateDistance(lat,lng,latCalicut, lngCalicut);
    print("distance $distance");
    if((distance)<50){
      return true;
    }
    else{
      return false;
    }
  }
}

double calculateDistance(lat1, lon1, lat2, lon2){
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 - c((lat2 - lat1) * p)/2 +
      c(lat1 * p) * c(lat2 * p) *
          (1 - c((lon2 - lon1) * p))/2;
  return 12742 * asin(sqrt(a));
}