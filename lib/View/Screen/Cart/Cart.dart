import 'package:back_nw/Controller/HomeController.dart';
import 'package:back_nw/Model/CartModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/Utils/Preferences.dart';
import 'package:back_nw/View/Screen/Home/Item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Model/DatabaseHelper.dart';
import '../../../Utils/NetworkUtils.dart';
import '../../Bottomtabs.dart';
import 'OrderSummary.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends StateMVC<Cart> {
  HomeController _con;

  _CartState() : super(HomeController()) {
    _con = controller;
  }

  final dbHelper = DatabaseHelper.instance;
  List<CartModel> product = [];
  var qty;
  bool loading;
  var grantTotal = 0;

  productList() async {
    loading = true;
    product = await dbHelper.getProducts();
    loading = false;
    getGrantTotal();
    isUserBlocked=await _con.isUserBlocked();
    setState(() {});
  }
bool isUserBlocked;
  @override
  void initState() {
    _con.getMinOrderValue();
    productList();
    super.initState();
  }

  int getTotalValue(int i) {
    int total = (int.parse(product[i].base_price) * int.parse(product[i].unit));
    return total;
  }

   getGrantTotal() {
    grantTotal = 0;
    List totals = [];
    for (var i in product) {
      var sum = int.parse(i.base_price) * int.parse(i.unit);
      totals.add(sum);
    }
    for (var i in totals) {
      grantTotal = grantTotal + i;
    }
  }
bool toContinue=false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ModalProgressHUD(
      inAsyncCall: toContinue,
      child: Scaffold(
        body: loading
            ? Center(child: CircularProgressIndicator())
            : Container(
                color: Color(0xFFF0F4F7),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: product.length == 0,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Cart",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700, fontSize: 21),
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.223,
                          ),
                          Center(
                              child: Text(
                            "NO ITEMS IN THE CART",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          )),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "Please add some of the items in \n cart that will appear here",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 18.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Bottomtabs()));
                            },
                            child: Container(
                              height: 45.0,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Color(0xfff01d3a),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "SHOP NOW",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: size.height * 0.71,
                      child: ListView.builder(
                          itemCount: product.length,
                          itemBuilder: (c, i) {
                            return Container(
                              padding: EdgeInsets.only(top: 10),
                              margin: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              height: 170,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 2.0,
                                        color: Colors.grey[100]),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xFFE9E9E9))),
                              child: ListTile(
                                title: Text(
                                    product[i].product_varient_name.toString()),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("qty : " + product[i].unit),
                                        Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                List list = [];
                                                int productID = int.parse(
                                                    product[i].product_id);
                                                int variantId = int.parse(
                                                    product[i].varient_id);
                                                //int quantity = int.parse(product[i].unit);
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (c) {
                                                  return Items(
                                                      variantId: variantId);
                                                }));
                                              },
                                              child: Container(
                                                  height: 60,
                                                  width: 80,
                                                  child: CachedNetworkImage(
                                                    imageUrl: imageUrl +
                                                        product[i]
                                                            .varient_image
                                                            .toString(),
                                                    fit: BoxFit.fitHeight,
                                                  )),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text("${getTotalValue(i)} /-",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                        height: 5,
                                        child: Divider(
                                          color: Colors.grey,
                                        )),
                                    Container(
                                      height: 70,
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (c) {
                                                  return BottomSheet(
                                                    onClosing: () {},
                                                    builder: (c) {
                                                      return Container(
                                                        height: 250,
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.all(
                                                                      10),
                                                              child: Row(
                                                                children: [
                                                                  Container(
                                                                    height: 140,
                                                                    width: 150,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        image: DecorationImage(
                                                                            image:
                                                                                CachedNetworkImageProvider(imageUrl + product[i].varient_image.toString()),
                                                                            fit: BoxFit.fitWidth)),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 15,
                                                                  ),
                                                                  Column(
                                                                    children: [
                                                                      Text(
                                                                        "Remove from cart ?",
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .bold,
                                                                            fontSize:
                                                                                16),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              margin:
                                                                  EdgeInsets.only(
                                                                      left: 10,
                                                                      right: 10,
                                                                      bottom: 5),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  buildButton(
                                                                      "Cancel",
                                                                      Colors
                                                                          .black,
                                                                      Colors
                                                                          .white,
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  buildButton(
                                                                      "Remove",
                                                                      Colors
                                                                          .white,
                                                                      Colors
                                                                          .black,
                                                                      () {
                                                                    dbHelper.delete(
                                                                        int.parse(
                                                                            product[i]
                                                                                .varient_id));
                                                                    productList();
                                                                    setState(
                                                                        () {});
                                                                    Navigator.pop(
                                                                        context);
                                                                  }),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                              );
                                            },
                                            child: Text(
                                              "Remove",
                                              textAlign: TextAlign.center,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    Visibility(
                      visible: grantTotal != 0,
                      child: Container(
                        height: 70,
                        width: 120,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\u20b9 ${grantTotal.toString()} /-",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () async {
                                toContinue=true;
                                setState(() { });
                                if(isUserBlocked){
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                        "You cant continue with this order,please contact admin"),
                                  ));
                                }
                                else {
                                  if (_con.minCartValue == null) {
                                    await _con.getMinOrderValue();
                                  }
                                  if (_con.minCartValue > grantTotal) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Minimum order value is ${_con
                                              .minCartValue}"),
                                    ));
                                  } else {
                                   await Preferences.setCartData(grantTotal);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrderSummary()));
                                  }
                                }
                                toContinue=false;
                                setState(() { });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 5),
                                height: 45,
                                width: 100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black),
                                child: Center(
                                    child: Text(
                                  "Confirm Order",
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Expanded buildButton(text, color, mainColor, onTap) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: mainColor,
            border: Border.all(color: Colors.black54)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: color),
          ),
        ),
      ),
    ));
  }
}
