import 'package:back_nw/Functions/location.dart';
import 'package:back_nw/Model/ApiModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Search",
                      style: TextStyle(
                          fontSize: 21,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(left: 9, right: 9),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[700],
                        blurRadius: 0.3,
                        offset: Offset(0.1, 0.5))
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Center(
                  child: TextField(
                    onChanged: (val) async {
                      await searchData(val);
                    },
                    controller: search,
                    cursorColor: Color(0xfff10627),
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 23,
                      ),
                      hintText: "Search Products",
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchList.length == 0 ? 0 : searchList.length,
                  itemBuilder: (c, i) {
                    return ListTile(
                      title: Text(searchList[i]["description"]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List searchList = [];

  searchData(String query) async {
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
    setState(() {});
  }
}
