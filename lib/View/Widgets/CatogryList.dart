import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CatogoryList extends StatelessWidget {
  final String image;
  final String title;
  CatogoryList({Key key,this.image, this.title}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(

        height: 120,
        width: 130,
        child:Card(elevation: 2.9,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Container(
               height:60,width: 60,
               child: CachedNetworkImage(
                  imageUrl: image,
                   placeholder: (context, url) => Image.asset("assets/images/placeholderimage.png",height: 45,width: 45,),
                   errorWidget: (context, url, error) => Icon(Icons.error),
          ),
             ),
              Padding(
                padding: const EdgeInsets.only(top: 5,bottom: 5,left: 3,right: 3),
                child: Text(title,textAlign: TextAlign.center,style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,
                ),),
              )
            ],
          ),
        ) ,
      ),
    );
  }
}
