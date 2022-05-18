import 'package:back_nw/Controller/UserLogRegController.dart';
import 'package:back_nw/Model/Loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'Otp.dart';

class Forgotpasswrd extends StatefulWidget {
  @override
  _ForgotpasswrdState createState() => _ForgotpasswrdState();
}

class _ForgotpasswrdState extends StateMVC<Forgotpasswrd> {
  UserLogRegController _con;


  _ForgotpasswrdState() :super(UserLogRegController()) {
    _con = controller;
  }

  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120, width: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xfff10627)),
              ),
              child: Center(
                child: Text("Logo", style: TextStyle(
                    color: Colors.black,
                    fontSize: 22

                ),),
              ),
            ),
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.042,),
          Text("Forgot Password", style: TextStyle(
              color: Colors.black, fontSize: 21, fontWeight: FontWeight.w600
          ),),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.042,),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: _mobileField(),
          ),
          SizedBox(height: MediaQuery
              .of(context)
              .size
              .height * 0.082,),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50, top: 20),
            child: _verifyField(),
          )
        ],
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
var verificationCode="";
  Widget _verifyField() {
    return GestureDetector(
      onTap: () {
        showLoading(context);
        _auth.verifyPhoneNumber(phoneNumber: "+91${phone.text}",
          verificationCompleted: (PhoneAuthCredential credential) async {
           bool isUserValid=await _con.forgotPassword(phone.text, context);
            print('verificationCompleted ${credential.smsCode}');
            if(!isUserValid){
              Fluttertoast.showToast(msg: 'No user found with this number');
            }
            else return null;
          },
          verificationFailed: (FirebaseAuthException e)async{
          print(e.message);
          Navigator.pop(context);
          },
          codeSent: (String verificationID, int resendToken){
            verificationCode=verificationID;
            print(verificationID);
            setState(() { });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>
                OtpPage(phoneNumber: phone.text,verificationID: verificationID)));
          },
          codeAutoRetrievalTimeout: (val){
          print("timeout : $val");
          Navigator.pop(context);
          },
        );
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 45.0,
        decoration: BoxDecoration(
            color: Color(0xfff10627),
            borderRadius: BorderRadius.circular(30),
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
          child: Text("Verify", style: TextStyle(
              color: Colors.white,
              fontSize: 16, fontWeight: FontWeight.bold
          ),),
        ),
      ),
    );
  }

  Widget _mobileField() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
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
        controller: phone,
        maxLength: 10,
        keyboardType: TextInputType.phone,
        textAlign: TextAlign.start,
        cursorColor: Color(0xfff10627),
        decoration: InputDecoration(
            counterText: "",
            prefixIcon: Icon(
              Icons.phone_android_outlined, color: Color(0xfff10627),
              size: 28,),
            hintText: "Enter Phone",
            hintStyle: TextStyle(fontSize: 17,
                color: Colors.grey[600]
            ),

            border: InputBorder.none
        ),
      ),
    );
  }
}
