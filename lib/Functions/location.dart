



import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

var userLoc;
Future<Position> locateUser() async {
  return Geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
}


Future<Placemark> getLocation()async{
  userLoc=await locateUser();
  List<Placemark> placeMarks = await placemarkFromCoordinates(userLoc.latitude, userLoc.longitude);
  var first = placeMarks.first;
  return first;
}