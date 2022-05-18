import 'dart:async';

import 'package:back_nw/View/Bottomtabs.dart';
import 'package:flutter/material.dart';

class OrderPlaced extends StatefulWidget {
  const OrderPlaced({Key key}) : super(key: key);

  @override
  State<OrderPlaced> createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
        return Bottomtabs();
      }), (route) => false);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 80,width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              child: Center(child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  child: Icon(Icons.done,color: Colors.white,size: 60,))),
              ),
              SizedBox(height: 20,),
              Text("Order Placed!",style: TextStyle(fontSize: 22),)
            ],
          ),
        ),
      ),
    );
  }
}
