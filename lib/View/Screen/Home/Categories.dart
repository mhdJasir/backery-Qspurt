import 'package:back_nw/Model/CategoryModel.dart';
import 'package:back_nw/View/Screen/Home/Item.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  Categories({this.categories});

  var categories = {};

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  var categoriesList = {};

  @override
  void initState() {
    setState(() {
      categoriesList = widget.categories;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xfff01d3a)),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded)),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Categories",
          style: TextStyle(color: Color(0xfff01d3a)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount:
                  categoriesList != null ? categoriesList["product"].length : 0,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 250,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                final item = categoriesList != null
                    ? categoriesList["product"][index]
                    : null;
                return CategoryModel(
                  discount: "10",
                  image: item['product_image'],
                  productName: item['product_name'].toString().length > 25 ?
                  item['product_name'].toString().substring(0, 23) + "..":
                  item['product_name'].toString(),mrp: "100",rs: "90",
                  isOnStock:index==1||index==3? false:true,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c){
                      return Items(product: categoriesList["product"][index],);
                    }));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

