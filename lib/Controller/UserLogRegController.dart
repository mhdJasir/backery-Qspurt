import 'package:back_nw/Model/ApiModel.dart';
import 'package:back_nw/Model/Loaders.dart';
import 'package:back_nw/Repository/UserRegLogRepository.dart' as repo;
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/View/Bottomtabs.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:back_nw/View/Loginpge/Login.dart';
import 'package:back_nw/View/Loginpge/SignUpOtp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/Constants.dart';

class UserLogRegController extends ControllerMVC {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> loginFormKey;

  var loginData = [];

  UserLogRegController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void setUserId(userIdPassed) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userIdPassed);
  }

  void setUserName(userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', userName);
  }

  void setUserEmail(userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userEmail', userEmail);
  }

  void setUserPhone(userPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userPhone', userPhone);
  }

  void signIn(phone, password, context) async {
    showLoading(context);
    await getDeviceId();
    repo.signIn(phone, password, deviceId, context).then((value) async {
      if (value["status"] == "1") {
        loginData = value["data"];
        setUserId(loginData[0]["user_id"].toString());
        setUserName(loginData[0]["user_name"].toString());
        setUserEmail(loginData[0]["user_email"].toString());
        setUserPhone(loginData[0]["user_phone"].toString());
        USERID = loginData[0]["user_id"].toString();
        setState(() {});
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Bottomtabs()));
      } else {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      }
    });
  }

  void signup(uname, phone, email, password, context) async {
    showLoading(context);
    repo
        .signupp(uname, phone, email, password, deviceId, context)
        .then((value) async {
      print(value);
      print(value["status"]);
      if (value["status"] == "1") {
        setUserId(value["data"]["user_id"].toString());
        setUserName(value["data"]["user_name"].toString());
        setUserPhone(value["data"]["user_phone"].toString());
        setUserEmail(value["data"]["user_email"].toString());

        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpOtpPage(
                      phoneNumber: value["data"]["user_phone"].toString(),
                    )));
      } else {
        Fluttertoast.showToast(
          msg: value["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pop(context);
      }
    });
  }

  Future updatePassword(phoneNumber, password, context) async {
    showLoading(context);
    var url = NetworkUtils.changePassword;
    var body = {
      "user_phone": phoneNumber,
      "user_password": password,
    };
    var data = await httpPost(url, body: body);
    Fluttertoast.showToast(msg: data["message"]);
    if (data["status"] == "1") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignIn()));
    } else
      Navigator.pop(context);
  }

  Future verifyOtp(phoneNumber, otp, context) async {
    print('verifying otp');
    var url = NetworkUtils.verifyOtp;
    var body = {
      "user_phone": phoneNumber,
      "otp": otp,
    };
    var data = await httpPost(url, body: body);
    Fluttertoast.showToast(msg: data["message"]);
    if (data["status"] == "1") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottomtabs()),
          (route) => false);
    } else
      Navigator.pop(context);
  }

  Future<bool> forgotPassword(phone, context) async {
    showLoading(context);
    var url = NetworkUtils.forgetPassword;
    var body = {"user_phone": phone.toString()};
    var value = await httpPost(url, body: body);
    Fluttertoast.showToast(
      msg: value["message"],
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 35,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    if (value["status"] == "1") {
      return true;
    } else
      return false;
  }
}
