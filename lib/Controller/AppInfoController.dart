

import 'package:back_nw/Model/ApiModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:get/get.dart';

class AppInfoController extends GetxController{
  Map<dynamic, dynamic> appInfo={}.obs;
@override
  onInit(){
    super.onInit();
    getAppInfo();
  }

  getAppInfo()async{
    var url=NetworkUtils.app_info;
    var data=await httpGet(url);
    if(data["status"]=="1"){
     appInfo=data["data"];
    }
  }
}