



import 'package:back_nw/View/Screen/Home/Item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Products extends StatefulWidget {
  Products({this.prod});
  var prod;
  @override
  _ProductsState createState() => _ProductsState();


}

class _ProductsState extends State<Products> {

  var arrProd =[];

  @override
  void initState() {

    setState(() {
      arrProd =widget.prod ;
    });
  }
  @override
  Widget build(BuildContext context) {
    print("hereee");
  print(widget.prod);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color:   Color(0xfff01d3a)),
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios_rounded)),
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("Products",style: TextStyle(color: Color(0xfff01d3a)),),
      ),
      body:   SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 3.0,right: 3.0),
          child: Container(
          //  height:1/2*724,
            child: GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: arrProd != null ? arrProd.length : 0,
                physics: NeverScrollableScrollPhysics(),

                gridDelegate:new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.67,
                    mainAxisSpacing: 1.9,
                  crossAxisSpacing: 3.8
                ),

                itemBuilder: (BuildContext context,int index){
                  final item = arrProd != null ?arrProd[index] : null;
                  print("LLLL"+item.toString());
                  return Padding(
                    padding: const EdgeInsets.only(top: 12,left: 3,right: 3),
                    child: GestureDetector(
                      onTap: (){
                        print("PPPRRRRR");
                        if(item['product_varient'] == null){
                          // Fluttertoast.showToast(
                          //     msg: "Product variant not available !",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: Colors.grey,
                          //     textColor: Colors.white,
                          //     fontSize: 16.0
                          // );
                        }else{
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Items(product: item['product_varient'],)));
                          print(item['product_varient']);

                        }
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
                            children:<Widget> [
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    child: Text("\u20B920 Off",style: TextStyle(fontSize: 10,color: Colors.white,fontWeight: FontWeight.w500),),
                                    color: Color(0xffa30d00),
                                    padding: EdgeInsets.only(top: 4,bottom: 3,right: 2,left: 2),
                                  ),

                                ),
                              ),
                              Container(
                                height:100,width: 100,
                                child: CachedNetworkImage(
                                  imageUrl: "https://v.3multi.qgrocer.in/public/"+item['product_image'],
                                  placeholder: (context, url) => Image.asset("assets/images/placeholderimage.png",height: 45,width: 45,),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(item['product_name'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700),)
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Container(
                                  height: 26,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color:index==1||index==4? Colors.green: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(child:index==1||index==4? Text("Available",style: TextStyle(color: Colors.white),):
                                  Text("Out of Stock",style: TextStyle(color: Colors.white),)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 14,right: 12,left: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("\u20b9 "+item['product_varient'][0]["base_mrp"].toString(),style: TextStyle(decoration: TextDecoration.lineThrough,color: Colors.grey[500]),),

                                    Text("\u20b9 "+item['product_varient'][0]["base_price"].toString(),style: TextStyle(color: Colors.grey[900],fontWeight: FontWeight.w700)),

                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                      ),
                    ),
                  );
                },
             ),
          ),
        ),
      ),
    );
  }
}
