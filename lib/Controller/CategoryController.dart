


import 'package:back_nw/Model/ApiModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController{

  List categories=[].obs;
  @override
 onInit(){
   super.onInit();
   getCategories();
 }

  getCategories()async{
    var url=NetworkUtils.cat;
    var data=await httpGet(url);
    if(data["status"]=="1"){
      for(var i in data["data"]){
        categories.add(i);
      }
    }
  }
}