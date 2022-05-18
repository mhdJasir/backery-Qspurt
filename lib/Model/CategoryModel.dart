import 'package:back_nw/Constants/ColorConstants.dart';
import 'package:back_nw/Constants/Icons.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryModel extends StatelessWidget {
  CategoryModel({@required this.discount, @required this.image,
    @required this.productName,@required this.mrp,@required this.rs,
    @required this.isOnStock,this.onTap
  });

  String discount;
  String image;
  String productName;
  String mrp;
  String rs;
  bool isOnStock;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: lightBorder),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        padding: EdgeInsets.only(top: 15,),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(alignment: Alignment.topLeft, child: discountFlag()),
            Transform.scale(
              scale: 0.8,
              child: CachedNetworkImage(
                imageUrl: imageUrl + image,
                height: 100,
                fit: BoxFit.contain,
                placeholder: (context, url) => Image.asset(
                  placeHolder,
                  height: 45,
                  width: 45,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(productName),
            SizedBox(height: 10,),
            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: onStock(),
            ),
            Padding(
              padding:  EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("\u20B9$mrp",style: TextStyle(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                  Text("\u20B9$rs",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget onStock(){
    return Container(
      height: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isOnStock?onStockColor:outOfStock,
      ),
      child: Center(child: Text(isOnStock?"Available":"Out of stock",
        style: TextStyle(color: Colors.white),)),
    );
  }
  Widget discountFlag() {
    return Container(
      height: 20,
      width: 65,
      color: discountFlagColor,
      child: Center(
          child: Text(
            "\u20B9$discount off",
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
