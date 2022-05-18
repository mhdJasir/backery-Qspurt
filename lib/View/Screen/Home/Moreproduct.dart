
import 'package:back_nw/Controller/HomeController.dart';
import 'package:back_nw/View/Screen/Home/Item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class Moreprod extends StatefulWidget {
  Moreprod({this.allpr});
  var allpr;
  @override
  _MoreprodState createState() => _MoreprodState();
}

class _MoreprodState extends StateMVC<Moreprod> {
  HomeController _con;
  _MoreprodState() : super(HomeController()) {
    _con = controller;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.allproductlist();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _con.allProducts!=null?SafeArea(
        child: Container(

          child: GridView.builder(
              shrinkWrap: true,
              itemCount: _con.allProducts!=null?_con.allProducts.length:0,
              gridDelegate:new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.77,

              ),
              itemBuilder: (BuildContext context,int indexx){
                final allproduct = _con.allProducts != null ? _con.allProducts[indexx] : null;
                print("wwwwwww"+allproduct.toString());
                return Padding(
                  padding: const EdgeInsets.only(top: 12,left: 3,right: 3),
                  child: GestureDetector(
                    onTap: (){
                      print("TAPPPEDDDDDDDDD");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Items(product:allproduct["product_varient"],)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300],
                                blurRadius: 2.0,
                                offset: Offset(0.2,0.2)
                            ),]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(

                              child: Center(child: CachedNetworkImage(
                                imageUrl:   "https://v.3multi.qgrocer.in/public/"+allproduct["product_image"].toString(),
                                placeholder: (context, url) => Container(
                                    height: 150,child: Image.asset("assets/images/placeholderimage.png")),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              )),height: 90,

                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(allproduct["product_name"],style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                height: 26,
                                width: 120,
                                decoration: BoxDecoration(
                                  color:allproduct["product_varient"][0]["stock"].toString()=="0"?  Colors.red: Colors.green,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:  Center(child:allproduct["product_varient"][0]["stock"].toString()=="0"?  Text("Out of Stock",style: TextStyle(color: Colors.white),):
                                Text("Availble",style: TextStyle(color: Colors.white),)
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 14,right: 12,left: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(allproduct["product_varient"][0]["base_mrp"].toString(),style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey[500]),),


                                  Text(allproduct["product_varient"][0]["base_price"].toString(),style: TextStyle(color: Colors.grey[900],fontWeight: FontWeight.w700)),

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
      ):CircularProgressIndicator()
    );
  }
}
