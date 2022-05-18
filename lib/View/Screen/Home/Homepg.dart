import 'package:back_nw/Controller/CategoryController.dart';
import 'package:back_nw/Controller/HomeController.dart';
import 'package:back_nw/Controller/locationController.dart';
import 'package:back_nw/Functions/Components.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/View/Screen/Home/Categories.dart';
import 'package:back_nw/View/Screen/Home/Item.dart';
import 'package:back_nw/View/Screen/Home/Moreproduct.dart';
import 'package:back_nw/View/Widgets/CatogryList.dart';
import 'package:back_nw/View/Widgets/GoogleMap.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Functions/location.dart';
import '../../GlobalVar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends StateMVC<Home> {
  HomeController _con;

  _HomeState() : super(HomeController()) {
    _con = controller;
  }

  bool isServiceable=false;
  checkLocation() async {
    if(userLat ==null) {
      var location = await locateUser();
      isServiceable = await locController.isServiceable(location.latitude,location.longitude);
    }else {
      isServiceable = await locController.isServiceable(userLat,userLng);
    }
    setState(() {});
  }

  @override
  void initState() {
    _con.getBannerList();
    _con.topSix();
    checkLocation();
    super.initState();
  }

  final catController = Get.put(CategoryController());
  final locController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.only(left: 6.0, right: 6.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            blurRadius: 0.2,
                            offset: Offset(0.1, 0.2))
                      ],
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        cursorColor: Color(0xff1990ca),
                        style: TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey[400],
                              size: 23,
                            ),
                            hintText: "Find Something",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 30,
                    color: Colors.red,
                    child: Marquee(text : "we are open morning 7:00 AM to 11 AM",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),
                        blankSpace: 20.0,
                        velocity: 100.0,
                        pauseAfterRound: Duration(seconds: 1),
                        startPadding: 20.0,
                        accelerationDuration: Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        decelerationDuration: Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                    ),
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  _con.bannerList.isNotEmpty
                      ? Container(
                          child: new CarouselSlider.builder(
                              options: CarouselOptions(
                                viewportFraction: 0.9,
                                autoPlayAnimationDuration: Duration(seconds: 3),
                                scrollDirection: Axis.horizontal,
                                initialPage: 0,
                                enlargeCenterPage: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayInterval: const Duration(seconds: 4),
                                autoPlay: true,
                              ),
                              itemCount: _con.bannerList == null
                                  ? 0
                                  : _con.bannerList.length,
                              itemBuilder:
                                  (BuildContext context, int itemIndex) {
                                return CachedNetworkImage(
                                  imageUrl: imageUrl +
                                      _con.bannerList[itemIndex]
                                          ["banner_image"],
                                  placeholder: (context, url) => Container(
                                      height: 200,
                                      child: Image.asset(
                                          "assets/images/placeholderimage.png")),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                );
                              }))
                      : Container(
                          height: 0,
                        ),
                  SizedBox(
                    height: 5,
                  ),
                  Visibility(
                      visible: !isServiceable,
                      child: sbh(50)),
                  Visibility(
                    visible: isServiceable,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 7,
                        left: 7,
                      ),
                      child: Text(
                        "Explore Categories",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 15,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Visibility(
                    visible: isServiceable,
                    child: Container(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            _con.categories != null ? _con.categories.length : 0,
                        itemBuilder: (context, index) {
                          final item = _con.categories != null
                              ? _con.categories[index]
                              : null;
                          return GestureDetector(
                            onTap: () {
                              var map = {};
                              var list = catController.categories
                                  .where((element) =>
                                      element["cat_id"] ==
                                      _con.categories[index]["cat_id"])
                                  .toList();
                              map = list[0];
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Categories(categories: map)));
                            },
                            child: Container(
                              child: CatogoryList(
                                image: imageUrl + item['image'],
                                title: item['title'].toString(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  isServiceable==null?
                      Center(child: CircularProgressIndicator()):
                  Visibility(
                    visible: !isServiceable&&isServiceable!=null,
                    child: Column(
                      children: [
                        Text(
                          "Currently we are not delivering in your area",
                          style: TextStyle(color: Colors.red),
                        ),
                        sbh(50),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                                return GoogleMapWidget();
                              }));
                            },
                            child: Container(
                              height: 60,
                              width: width(context) * 0.9,
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Change Location",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _con.allProducts.isNotEmpty && isServiceable && isServiceable!=null
                      ? Padding(
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          child: Container(
                            height: 10 * 117.toDouble(),
                            child: GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.77,
                                ),
                                itemBuilder:
                                    (BuildContext context, int indexx) {
                                  final allproduct = _con.allProducts != null
                                      ? _con.allProducts[indexx]
                                      : null;
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12, left: 3, right: 3),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (allproduct.toString() == null) {
                                        } else {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Items(
                                                product: allproduct[
                                                    "product_varient"],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey[300],
                                                  blurRadius: 2.0,
                                                  offset: Offset(0.2, 0.2)),
                                            ]),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 7),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Center(
                                                    child: CachedNetworkImage(
                                                  imageUrl:
                                                      "https://v.3multi.qgrocer.in/public/" +
                                                          allproduct[
                                                                  "product_image"]
                                                              .toString(),
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          height: 150,
                                                          child: Image.asset(
                                                              "assets/images/placeholderimage.png")),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                )),
                                                height: 90,
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8),
                                                  child: Text(
                                                    allproduct["product_name"],
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: Container(
                                                  height: 26,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        allproduct["product_varient"]
                                                                            [0][
                                                                        "stock"]
                                                                    .toString() ==
                                                                "0"
                                                            ? Colors.red
                                                            : Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Center(
                                                      child: allproduct["product_varient"]
                                                                          [0]
                                                                      ["stock"]
                                                                  .toString() ==
                                                              "0"
                                                          ? Text(
                                                              "Out of Stock",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          : Text(
                                                              "Available",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 14,
                                                    right: 12,
                                                    left: 12),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "\u20b9" +
                                                          allproduct["product_varient"]
                                                                      [0]
                                                                  ["base_mrp"]
                                                              .toString(),
                                                      style: TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          color:
                                                              Colors.grey[500]),
                                                    ),
                                                    Text(
                                                        "\u20b9" +
                                                            allproduct["product_varient"]
                                                                        [0][
                                                                    "base_price"]
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[900],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      : Container(
                          height: 0,
                        )
                ],
              ),
              _con.allProducts.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Moreprod(
                                        allpr: _con.allProducts[0],
                                      )));
                        },
                        child: Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              "View More",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.grey[800],
                                  fontSize: 15),
                            )),
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
