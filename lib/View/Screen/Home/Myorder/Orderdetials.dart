import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class OrderDetails extends StatefulWidget {
  final details;
  OrderDetails({this.details});

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:  Colors.white),
        backgroundColor: Color(0xff1990ca),
        title: Text("Order Details",style: TextStyle(color:  Colors.white),),
      ),
      body: Container(
        color: Color(0xfff6f8f7),
        child: Container(
          margin:EdgeInsets.only(bottom: 22,top: 4) ,
          // margin: EdgeInsets.only(bottom: 6),,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            elevation: 1,
            child: Container(
                child:Container(
                  // padding:EdgeInsets.only(bottom: 6) ,
                  padding: EdgeInsets.only(left: 5,top: 5),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 75,height: 65,
                        child:
                        Padding(
                          padding: const EdgeInsets.only(top: 11,left: 5),
                          child: CachedNetworkImage(
                            imageUrl:"https://v.3multi.qgrocer.in/public/"+widget.details[0]["varient_image"].toString(),
                            placeholder: (context, url) => Container(
                                height: 55,width: 65,child: Image.asset("assets/images/1220.png")),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          // Image.asset(widget.details[0]["varient_image"].toString(),height: 60,width: 80,),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.details[0]["product_name"].toString(),style: TextStyle(fontWeight: FontWeight.w600,
                              color: Colors.black,fontSize: 15),),
                          Text(widget.details[0]["description"].toString(),style: TextStyle(fontWeight: FontWeight.w600,
                              color: Colors.grey[600],fontSize: 13),),
                          Text("Qty - ${widget.details[0]["quantity"].toString()+widget.details[0]["unit"].toString()}",style: TextStyle(fontWeight: FontWeight.w400,
                              color: Colors.black,fontSize: 15),),
                          SizedBox(height: 2,),
                          Text("\u20b9${ widget.details[0]["price"].toString()}")



                        ],
                      ),

                    ],
                  ),


                )
            ),
          ),
        )


      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){},
          backgroundColor: Color(0xff1990ca),
          label: Padding(
            padding: const EdgeInsets.only(left: 5,right: 5),
            child: Text("Cancel"),
          )),
    );
  }
}
