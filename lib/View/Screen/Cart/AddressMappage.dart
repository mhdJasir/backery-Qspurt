import 'dart:async';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class AddressMappage extends StatefulWidget {
  @override
  _AddressMappageState createState() => _AddressMappageState();
}

class _AddressMappageState extends State<AddressMappage> {

  GoogleMapController myController;
  var latt,longg;

  BitmapDescriptor pinLocationIcon;



  @override
  void initState() {
    super.initState();
    print(userLocation);
    getUserLocation();



  }
  getUserLocation() async {
    var userloc = await locateUser();
    setState(() {
      userLocation = userloc;
    });
    setState(() {
      latt=userloc.latitude;
      longg=userloc.longitude;
    });
  }

  Future<Position> locateUser() async {
    return Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
  }
  //PickResult selectedPlace;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: latt==null||longg==null?Center(
        child: CircularProgressIndicator(),
      ):SafeArea(
        child: Stack(
          children: <Widget>[
        //  PlacePicker(
        //   apiKey: Apikey.apikey,
        //   initialPosition: LatLng(latt,longg),
        //   useCurrentLocation: true,
        //
        //   selectInitialPosition: true,
        //    //usePlaceDetailSearch: true,
        //   onPlacePicked: (result) {
        //     selectedPlace = result;
        //     print(selectedPlace.formattedAddress ?? "");
        //     setState(() {
        //       Pickedplace = selectedPlace.formattedAddress;
        //     });
        //
        //     Navigator.pop(context);
        //   },
        //
        // ),
          ],
        ),
      ),
    );
  }
}
