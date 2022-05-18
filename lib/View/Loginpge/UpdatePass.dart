

import 'package:back_nw/Controller/UserLogRegController.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class Updatepasswrd extends StatefulWidget {
  String phoneNumber;
  Updatepasswrd(this.phoneNumber);
  @override
  _UpdatepasswrdState createState() => _UpdatepasswrdState();
}

class _UpdatepasswrdState extends StateMVC<Updatepasswrd> {
  UserLogRegController _controller;
  _UpdatepasswrdState():super(UserLogRegController()){
    _controller=controller;
  }
final password=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120,width: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 1,  color:Color(0xfff10627)),
              ),
              child: Center(
                child: Text("Logo",style: TextStyle(
                    color: Colors.black,
                    fontSize: 22

                ),),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.042,),
          Text("Update Password",style: TextStyle(
              color: Colors.black,fontSize: 21,fontWeight: FontWeight.w600
          ),),
          SizedBox(height: MediaQuery.of(context).size.height*0.042,),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50),
            child: _password(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.082,),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 50,top: 20),
            child: _submittbtn(),
          )
        ],
      ) ,
    );
  }
  Widget _password(){
    return Container(
      decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(
                    0.0,
                    2.0
                ),
                blurRadius: 4.0,
                color: Colors.grey
            )
          ]
      ),
      child: TextFormField(
        controller: password,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.start,
        cursorColor:Color(0xfff10627),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 15),
            hintText: "New Password ",
            hintStyle: TextStyle(fontSize: 17,
                color: Colors.grey[600]
            ),

            border: InputBorder.none
        ),
      ),
    );
  }
  Widget _submittbtn(){
    return GestureDetector(
      onTap: ()async{
        await _controller.updatePassword(widget.phoneNumber,password.text,context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        decoration: BoxDecoration(
            color:Color(0xfff10627),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  offset: Offset(
                      0.0,
                      2.0
                  ),
                  blurRadius: 4.0,
                  color: Colors.grey
              ),
            ]
        ),

        child: Center(
          child: Text ("Submit",style: TextStyle(
              color: Colors.white,
              fontSize: 16,fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }

}
