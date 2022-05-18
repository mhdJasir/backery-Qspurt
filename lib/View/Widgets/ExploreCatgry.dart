import 'package:flutter/material.dart';
class ExploreCate extends StatelessWidget {
  final Color color;
  final String title;
  final Function tap;


  ExploreCate({Key key, this.color, this.title, this.tap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 70,width: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10)
            ),
          ),
          SizedBox(height: 6,),

          Text(title,style: TextStyle(color: Colors.grey[600],fontSize: 11),)
        ],
      ),
    );
  }
}
