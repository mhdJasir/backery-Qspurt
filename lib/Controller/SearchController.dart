



import 'package:back_nw/Functions/location.dart';
import 'package:back_nw/Model/ApiModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:get/get.dart';

class SearchController extends GetxController{

  List searchList =[].obs;
  var query=''.obs;
  @override
  onInit(){
    super.onInit();
    searchData();
  }
  searchData() async {
    searchList = [];
    var loc = await locateUser();
    var place = await getLocation();
    var url = NetworkUtils.search;
    var body = {
      "keyword": query,
      //"lat": "${loc.latitude}",
      "lat": "11.601558",
      "lng": "75.5919758",
      //"lng": "${loc.longitude}",
      "city": "calicut"
      //"city": place.subAdministrativeArea
    };
    var data = await httpPost(url, body: body);
    print(data);
    if (data["status"] == "1") {
      for (var i in data["data"]) searchList.add(i);
    }
  }

}