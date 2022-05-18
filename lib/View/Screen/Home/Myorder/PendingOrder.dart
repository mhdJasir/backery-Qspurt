
import 'package:back_nw/Controller/BottomtabsController.dart';
import 'package:back_nw/View/Screen/Home/Myorder/Orderdetials.dart';
import 'package:back_nw/View/Widgets/Style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:timelines/timelines.dart';
class PendingOrder extends StatefulWidget {

  @override
  _PendingOrderState createState() => _PendingOrderState();
}

class _PendingOrderState extends StateMVC<PendingOrder> {
  BottomController _con;
  _PendingOrderState() : super(BottomController()) {
    _con = controller;
  }

  @override
  void initState() {
   _con.pendingordr();
   print("yyyyyyyyyyyyyyyy"+_con.userid.toString());
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
        return Scaffold(
      backgroundColor: Color(0xfffafafa),
      body:_con.pordrdetails!=null ?  ListView.builder(
          itemCount: _con.pordrdetails != null ? _con.pordrdetails.length : 0,
          itemBuilder: (context,index) {
            print("ANAS");
            return  Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 450,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(7),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffdedede),
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                      offset: Offset(1.0, 1.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10,top: 10),
                      child: Container(alignment: Alignment.centerRight,
                          child: Text("Payment ${_con.pordrdetails[index]["payment_status"]}",style: TextStyle(color:Color(0xfff01d3a),fontSize: 15),)),
                    ),
                                     Padding(
                      padding: const EdgeInsets.only(right: 10,left: 10,top: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Order Assign",style: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16
                          ),),
                          Row(
                            children: [
                              Icon(Icons.keyboard_arrow_down_outlined,size: 28,),
                              SizedBox(width: 2,),
                              Icon(Icons.phone,color: Colors.green[400],)
                            ],
                          )
                        ],),
                    ),

                    SizedBox(height: 12,),
                    Row(
                      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Order Id - ",style: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w800),),
                                  Text(_con.pordrdetails[index]["cart_id"],style: f13BlkB6)
                                ],
                              ),
                              SizedBox(height: 3,),
                              Row(
                                children: [
                                  Text("Placed On - ",style: f14Gry,),
                                  Text(_con.pordrdetails[index]["data"][0]["order_date"],style: f13BlkB6,)
                                ],
                              ),
                              SizedBox(height: 3,),
                              Row(
                                children: [
                                  Text("Time - ",style: f14Gry),
                                  Text(_con.pordrdetails[index]["time_slot"],style: f13BlkB6)
                                ],
                              ),
                              SizedBox(height: 3,),
                              Row(
                                children: [
                                  Text("Item Qty - ",style: f14Gry),
                                  Text(_con.pordrdetails[index]["data"][0]["qty"].toString(),style: f13BlkB6)
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 70,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25),
                          child: Column(
                            children: [
                              Text("Order mode",style: TextStyle(color: Colors.grey[500],fontSize: 17),),
                              Text(_con.pordrdetails[index]["payment_method"],style: TextStyle(color: Color(0xfff01d3a),fontSize: 14),)

                            ],
                          ),
                        )
                      ],
                    ),
                    Divider( color: Colors.grey[400],thickness: 2,),

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text("Order Amount - ",style: f14Gry,),
                              Text("\u20b9 ${_con.pordrdetails[index]["price"]}",style: f13BlkB6,)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 7.0,top: 5.0),
                            child: Icon(FontAwesomeIcons.infoCircle,color: Color(0xfffa810c),size: 18,),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Text("Payable Amount - ",style: f14Gry),
                          Text("\u20b9 ${_con.pordrdetails[index]["remaining_amount"]}",style: f13BlkB6,)
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                     color: Colors.grey[200],
                      height: 110,
                      child: Timeline.tileBuilder(scrollDirection: Axis.horizontal,
                        builder: TimelineTileBuilder.fromStyle(
                          contentsAlign: ContentsAlign.reverse,
                          contentsBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text('Timeline Event $index'),
                          ),
                          itemCount: 2,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,right: 5),
                      child:   GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderDetails()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color:Color(0xfff01d3a),
                            borderRadius: BorderRadius.circular(30),

                          ),

                          child: Center(
                            child: Text ("Order Detail's",style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 14,),
                    Padding(
                        padding: const EdgeInsets.only(right: 8,left: 8),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40.0,
                          decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(spreadRadius: 0.5,
                                    offset: Offset(
                                        0.3,
                                        1.2
                                    ),
                                    blurRadius: 1.8,
                                    color: Colors.grey[300]
                                ),
                              ]

                          ),


                          child: Center(
                            child: Text (_con.pordrdetails[index]["order_status"],style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,fontWeight: FontWeight.w600
                            ),

                          ),





                        )
                        ),)],
                ),
              ),
            );
          }):
      _con.userid==null?Center(
        child: Text("Order Cannot Found"),
      ):Center(
        child: CircularProgressIndicator(),

      )
    );
  }
}
