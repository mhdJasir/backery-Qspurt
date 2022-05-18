import 'dart:convert';

import 'package:back_nw/Functions/Components.dart';
import 'package:back_nw/Functions/location.dart';
import 'package:back_nw/Model/Loaders.dart';
import 'package:back_nw/Repository/CartRepo.dart' as repo;
import 'package:back_nw/View/Screen/Cart/Selctaddress.dart';
import 'package:back_nw/View/Screen/Cart/ordercomplrted.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../Model/ApiModel.dart';
import '../Utils/NetworkUtils.dart';
import '../View/GlobalVar.dart';

class CartController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;

  var userLocation;
  var checkdata;
  List viewAddresses = [];
  List UserAddress = [];
  List timeslotlist = [];
  bool loading = true;

  CartController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  Future applyCoupon(couponCode, cartId) async {
    var url = NetworkUtils.applyCoupon;
    var body = {
      "coupon_code": couponCode,
      "cart_id": cartId,
    };
    var data = await httpPost(url, body: body);
    Fluttertoast.showToast(msg: data["message"]);
    if (data["status"] == "1") {}
  }

  getMinOrderValue() async {
    var deliveryCharge;
    var url = NetworkUtils.minCartValue;
    var data = await httpGet(url);
    if (data["status"] == "1") {
      deliveryCharge = data["data"]["del_charge"];
    }
    return deliveryCharge;
  }

  Future<bool> makeOrder(date, slot, list) async {
    var url = "${NetworkUtils.makeAnOrder}?user_id=$USERID"
        "&delivery_date=$date&time_slot=$slot&store_id=22&order_array=${json.encode(list)}";
    print(url);
    var body = {
      "user_id": USERID,
      "delivery_date": date,
      "time_slot": slot,
      "store_id": "2",
      "order_array": json.encode(list),
    };
    var data = await httpPost(url);
    Fluttertoast.showToast(msg: data["message"]);
    print(data);
    if (data["status"] == "1") {
      return true;
    } else
      return false;
  }

  Map paymentMethods = {};

  getPaymentModes() async {
    var url = NetworkUtils.paymentMethods;
    var data = await httpGet(url);
    if (data["status"] == "1") {
      paymentMethods = data["data"];
    }
  }

  Future timeSlot(dateFormat) async {
    await repo.timeslot(dateFormat).then((value) {
      if (value["status"].toString() == "1") {
        timeslotlist = value["data"];
        loading = false;
        setState(() {});
      } else {
        loading = false;
        Fluttertoast.showToast(
            msg: value["message"].toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {});
      }
    });
  }

  void addadress(pin, housno, socity, lndmrk, name, phon, contxt) async {
    showLoading(contxt);
    var first = await getLocation();
    var loc = await locateUser();
    var city = first.administrativeArea;
    var lat = loc.latitude.toString();
    var lng = loc.longitude.toString();
    repo
        .addAddress(pin, housno, socity, lndmrk, name, phon, lat, lng, city)
        .then((value) {
      Navigator.pop(contxt);
      if (value["status"] == "1") {
        Fluttertoast.showToast(
            msg: value["message"],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushReplacement(
            contxt, MaterialPageRoute(builder: (context) => SelectAddress()));
      } else
        Fluttertoast.showToast(msg: "something went wrong");
    });
  }

  void checkout(pmod, pstts, wallet, context) async {
    print(pmod);
    print(pstts);
    await repo.checkoutdataas(pmod, pstts, wallet).then((value) {
      print(value.toString());
      print(value["message"]);
      if (value["status"] == "1") {
        setState(() {
          checkdata = value;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OrderCompleted(
                      checkdta: checkdata,
                    )));
      } else {
        Fluttertoast.showToast(
          msg: 'Please Select Payment Method',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          fontSize: 16.0,
        );
      }
    });
  }

  Future editAddress(addressId, name, mobileNumber, city, society, house,
      landMark, pin, context) async {
    showLoading(context);
    var userLocation = await locateUser();
    var lat = userLocation.latitude;
    var lng = userLocation.longitude;
    await repo
        .editAddress(addressId, name, mobileNumber, city, society, house,
            landMark, pin, lat, lng)
        .then((value) {
      Navigator.pop(context);
      if (value != null) {
        Fluttertoast.showToast(msg: value['message']);
        if (value['status'] == "1") {
          moveBack(context, SelectAddress());
        }
      }
    });
  }

  void viewAddress() async {
    await repo.getAddresses().then((value) {
      if (value["status"] == "1") {
        setState(() {
          viewAddresses = value["data"];
        });
        print(viewAddresses);
      } else
        Fluttertoast.showToast(msg: value['message']);
    });
  }
}
