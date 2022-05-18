import 'dart:convert';

import 'package:back_nw/View/GlobalVar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:back_nw/Repository/HomeRepo.dart'as repo;

import '../Functions/location.dart';
import '../Model/ApiModel.dart';
import '../Utils/NetworkUtils.dart';
class HomeController extends ControllerMVC{
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> FormKey;
  List bannerList =[];
  List categories=[];
  List allProducts=[];
  var termm="";
  var abouttt="";

  List variants=[];
  Future<List> getVariants(productId)async{
    var url=NetworkUtils.variant;
    var loc=await locateUser();
    var body={
      "product_id":productId.toString(),
      "lat":userLat.toString()??loc.latitude.toString(),
      "lng":userLng.toString()??loc.longitude.toString(),
      "city":"calicut",
    };
    var data=await httpPost(url,body: body);
    if(data["status"]=="1") {
      variants = data["data"];
    }
    return variants;
  }

  void getBannerList()async{
    repo.getBannerList().then((value) {
      if(value["status"]=="1"){
        setState(() {
          bannerList = value["data"];
        });
      }
    });
  }

  Future getAppNotice()async{
    var url=NetworkUtils.appNotice;
    var data=await httpGet(url);
  }

  Future<bool> isUserBlocked()async{
    var url=NetworkUtils.checkUserBlocked;
    var body={
      "user_id":USERID,
    };
    var data=await httpPost(url,body: body);
    if(data["status"]=="1"){
      return true;
    }
    else return false;
  }

  void topSix()async{
    var loc=await locateUser();
    var placeMark=await getLocation();
    var city=placeMark.subAdministrativeArea;
    print(city);
    var body={
      "lat":userLat.toString()??loc.latitude.toString(),
      "lng":userLng.toString()??loc.longitude.toString(),
      "city":"calicut"
    };
    print(body);
    final String url = NetworkUtils.topsix;
    var data=await httpPost(url,body: body);
      if(data["status"]=="1"){
        setState(() {
          categories=data["data"];
        });
      }
      else Fluttertoast.showToast(msg: 'service not available for this location');
    print(categories);
  }
  var minCartValue;
  getMinOrderValue()async{
    var url=NetworkUtils.minCartValue;
    var data=await httpGet(url);
    if(data["status"]=="1"){
      minCartValue=data["data"]["min_cart_value"];
    }
  }

  void allproductlist()async{
    repo.allprod().then((value) {
      if(value["status"]=="1"){
        setState(() {
          allProducts=value["data"];
        });
      }
    });
  }
  void termconditn()async{
    repo.trmconditn().then((value) {
      if(value["status"]=="1"){
       setState(() {
         termm=value["data"]["description"];
       });
      }
    });
  }
  void aboutus()async{

    print("Abouts");
    repo.aboutus().then((value) {
      print("sss"+value["status"].toString());
      if(value["status"]=="1"){
        setState(() {
          abouttt=value["data"]["description"];
        });
        print("qwqeqwqeqew  "+abouttt.toString());

      }

    });

  }


}


