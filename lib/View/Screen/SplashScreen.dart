import 'dart:async';

import 'package:back_nw/Functions/Components.dart';
import 'package:back_nw/Utils/Preferences.dart';
import 'package:back_nw/Functions/location.dart';
import 'package:back_nw/Model/ApiModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/View/Bottomtabs.dart';
import 'package:back_nw/View/Loginpge/Login.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../GlobalVar.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      USERID = prefs.getString('userId');
    });
  }

  setUserAddress() async {
    var data = await getLocation();
    address = "${data.subLocality} ${data.locality} "
        "${data.postalCode} ${data.subAdministrativeArea} ${data.administrativeArea}";
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAppInfo();
    getUserId();
    setUserAddress();
    _timer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xfff10627),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Container(
                height: height(context),
                width: width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        appInfo["name"],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    appLogo != null
                        ? AnimatedContainer(
                            curve: Curves.elasticIn,
                            duration: Duration(seconds: 1),
                            child: CachedNetworkImage(
                              imageUrl: appLogo,
                              height: 200,
                              width: 200,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
    );
  }

  var appInfo = {};
  bool loading = true;

  getAppInfo() async {
    var url = NetworkUtils.app_info;
    var data = await httpGet(url);
    if (data["status"] == "1") {
      appInfo = data["data"];
    }
    appLogo = imageUrl + appInfo["favicon"];
    await Preferences.setAppIcon(appLogo);
    loading = false;
    setState(() {});
  }

  _timer() async {
    return Timer(Duration(seconds: 4), () {
      if (USERID.toString().isNotEmpty &&
          USERID.toString() != null &&
          USERID != null &&
          USERID.toString() != "null") {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Bottomtabs()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }
    });
  }
}
