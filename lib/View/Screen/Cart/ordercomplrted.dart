import 'package:flutter/material.dart';
class OrderCompleted extends StatefulWidget {
  var checkdta;
  OrderCompleted({this.checkdta});
  @override
  _OrderCompletedState createState() => _OrderCompletedState();
}

class _OrderCompletedState extends State<OrderCompleted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.checkdta["message"].toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w500),),
            Icon(Icons.check,color: Colors.green,size: 54,)
          ],
        ),
      ),
    );
  }
}
