


import 'package:back_nw/Constants/Constants.dart';
import 'package:back_nw/Model/ApiModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{

Map profileData={}.obs;
 Future getProfileData()async{
    var url=NetworkUtils.myprofile;
    var body={
    "user_id":USERID
    };
    var data=await httpPost(url,body: body);
    if(data["status"]=="1"){
      profileData=data["data"];
    }
  }

  Future editProfile(name,email,phone)async{
  await getDeviceId();
    var url=NetworkUtils.profile_edit;
    var body={
      "user_id":USERID,
      "device_id":deviceId.toString(),
      "user_name":name,
      "user_email":email,
      "user_phone":phone,
    };
    var data= await httpPost(url,body: body);
    Fluttertoast.showToast(msg: data['message']);
    if(data["status"]=="1"){

    }
  }
}