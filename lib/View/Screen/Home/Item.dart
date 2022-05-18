import 'package:back_nw/Controller/HomeController.dart';
import 'package:back_nw/Model/CartModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/View/Widgets/Style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../../Model/DatabaseHelper.dart';


class Items extends StatefulWidget {
  var product;
  var variantId;

  Items({this.product, this.variantId});

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends StateMVC<Items> {
  HomeController _controller;

  _ItemsState() : super(HomeController()) {
    _controller = controller;
  }

  int quantity = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (quantity != 0) quantity--;
    });
  }

  var productId;
  Map product;
  final dbHelper = DatabaseHelper.instance;

  @override
  void initState() {
    product = widget.product;
    setState(() {});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(product);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: CachedNetworkImage(
                  imageUrl: imageUrl + product["product_image"],
                  fit: BoxFit.contain,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 10, bottom: 1),
                child: Text(
                  product["product_name"].toString(),
                  style: f18B6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12),
                child: Text(
                  'description'.toString(),
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                    ),
                    child: Text(
                      "\u20b9" + 'base_price'.toString(),
                      style: f18B6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 12,
                      left: 12,
                    ),
                    child: Text(
                      "\u20b9" + 'base_mrp'.toString(),
                      style: TextStyle(
                          color: Colors.grey[900],
                          decoration: TextDecoration.lineThrough),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Quantity",
                      style: f17B6,
                    ),
                    Container(
                      height: 34,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[400]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              _decrement();
                              await dbHelper.delete(product['product_id']);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black),
                              width: 34,
                              height: 33,
                              child: Icon(FontAwesomeIcons.minus,
                                  color: Colors.white, size: 12),
                            ),
                          ),
                          Text(
                            "$quantity",
                            style: f17B6,
                          ),
                          GestureDetector(
                            onTap: () async {
                              List list = [];
                              _increment();
                              list = await getList();
                              print(list);
                              print("product id : ${product['product_id']}");
                              if (list
                                  .contains(product['product_id'].toString())) {
                                print("updating");
                                update(
                                    "100",
                                    "50",
                                    product['product_image'].toString(),
                                    product['product_name'].toString(),
                                    product['product_id'].toString(),
                                    quantity.toString(),
                                    product['product_id']);
                              } else {
                                print("inserting");
                                _insert(
                                    "100",
                                    "50",
                                    product['product_image'].toString(),
                                    product['product_name'].toString(),
                                    product['product_id'].toString(),
                                    quantity.toString(),
                                    product['product_id']);
                                list = await getList();
                                print(list);
                                setState(() {});
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.red),
                              width: 34,
                              height: 33,
                              child: Icon(
                                FontAwesomeIcons.plus,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12, left: 12, bottom: 10),
                child: Text(
                  "Similar Products",
                  style: f17B6,
                ),
              ),
              FutureBuilder(
                future: _controller.getVariants(product["product_id"]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 12, left: 12),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _controller.variants.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.77,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 5),
                        itemBuilder: (BuildContext context, int indexx) {
                          return GestureDetector(
                            onTap: () {
                              product["product_image"]= _controller.variants[indexx]["varient_image"];
                              product["product_name"]= _controller.variants[indexx]["description"];
                              product["product_id"]= _controller.variants[indexx]["varient_id"];
                              setState(() { });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3, right: 3),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[300],
                                          blurRadius: 2.0,
                                          offset: Offset(0.2, 0.2)),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        child: CachedNetworkImage(
                                          imageUrl: imageUrl +
                                              _controller.variants[indexx]
                                                  ["varient_image"],
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            "assets/images/placeholderimage.png",
                                            height: 45,
                                            width: 45,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            _controller.variants[indexx]
                                                ["description"],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w700),
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Container(
                                          height: 26,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: _controller.variants[indexx]
                                                        ['stock'] ==
                                                    0
                                                ? Colors.red
                                                : Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                              child: Text(
                                            _controller.variants[indexx]
                                                        ['stock'] ==
                                                    0
                                                ? "Out of Stock"
                                                : "Available",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14, right: 12, left: 12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\u20b9" + 'mrp'.toString(),
                                              style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.grey[500]),
                                            ),
                                            Text(
                                              "\u20b9" + 'price'.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey[900],
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  update(baseMrp, basePrice, img, vName, pId, columnUnit, vId) async {
    Map<String, dynamic> row = {
      DatabaseHelper.baseMrp: baseMrp,
      DatabaseHelper.basePrice: basePrice,
      DatabaseHelper.image: img,
      DatabaseHelper.productVariantName: vName,
      DatabaseHelper.productId: pId,
      DatabaseHelper.unit: columnUnit,
      DatabaseHelper.variantId: vId,
    };
    await dbHelper.update(row);
  }

  void _insert(baseMrp, basePrice, img, vName, pId, columnUnit, vId) async {
    Map<String, dynamic> row = {
      DatabaseHelper.baseMrp: baseMrp,
      DatabaseHelper.basePrice: basePrice,
      DatabaseHelper.image: img,
      DatabaseHelper.productVariantName: vName,
      DatabaseHelper.productId: pId,
      DatabaseHelper.unit: columnUnit,
      DatabaseHelper.variantId: vId,
    };
    await dbHelper.insert(row);
  }

  Future<List> getList() async {
    List varId = [];
    List<CartModel> list = [];
    list = await dbHelper.getProducts();
    for (var i in list) {
      varId.add(i.product_id);
      setState(() {});
    }
    return varId;
  }
}

class Product{
  final String name;
  final String image;
  final String descrription;
  final String basePrice;
  final String baseMrp;

  Product(this.name, this.image, this.descrription, this.basePrice, this.baseMrp);
}