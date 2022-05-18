import 'dart:async';

import 'package:back_nw/Functions/Components.dart';
import 'package:back_nw/View/Bottomtabs.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({Key key}) : super(key: key);

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  MarkerId _id = MarkerId("test");
  Marker _marker;
  bool dragged = false;

  @override
  void initState() {
    getInitialData();
    super.initState();
  }

  getInitialData() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _position = CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 17);
    _marker = Marker(
      markerId: _id,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          moveBack(context, Bottomtabs());
          return true;
        },
        child: Scaffold(
          body: _position == null
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Container(
                      height: height(context),
                      child: GoogleMap(
                        initialCameraPosition: _position,
                        markers: {_marker},
                        mapType: MapType.normal,
                        myLocationEnabled: true,
                        onCameraMove: (_position) async {
                          _updatePosition(_position);
                        },
                        onCameraIdle: () async {
                          await getAddress(lat, long);
                          dragged = true;
                          userLat = lat;
                          userLng = long;
                          setState(() {});
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    Visibility(
                      visible: dragged,
                      child: Positioned(
                        bottom: 5,
                        left: 10,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: width(context) * 0.8,
                          color: Colors.white,
                          child: Column(
                            children: [
                              sbh(10),
                              Text(address),
                              sbh(10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (c) {
                                    return Bottomtabs();
                                  }));
                                },
                                child: Container(
                                    height: 40,
                                    width: 100,
                                    color: Colors.red,
                                    child: Center(
                                        child: Text(
                                      "Select Here",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                              ),
                              sbh(5),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _updatePosition(CameraPosition _position) async {
    lat = _position.target.latitude;
    long = _position.target.longitude;
    _marker = _marker.copyWith(
      positionParam: LatLng(lat, long),
    );
    setState(() {});
  }

  var lat, long;
  CameraPosition _position;

  Future getAddress(latitude, longitude) async {
    print("getting address");
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latitude, longitude);
    var data = placeMarks.first;
    address = "${data.subLocality} ${data.locality} "
        "${data.postalCode} ${data.subAdministrativeArea} ${data.administrativeArea}";
    userCity = data.subAdministrativeArea;
    print(data);
    print(address);
    setState(() {});
  }
}
