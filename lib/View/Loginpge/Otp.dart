import 'package:back_nw/Model/Loaders.dart';
import 'package:back_nw/View/Loginpge/UpdatePass.dart';
import 'package:back_nw/View/Widgets/validate_Fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:pinput/pin_put/pin_put.dart';
import '../../Controller/UserLogRegController.dart';

class OtpPage extends StatefulWidget {
  var phoneNumber;
  final verificationID;

  OtpPage({this.phoneNumber, this.verificationID});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends StateMVC<OtpPage> {
  UserLogRegController _controller;
  _OtpPageState():super(UserLogRegController()){
    _controller=controller;
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  Validations validations = new Validations();
 String otp="";

  @override
  void initState() {
    super.initState();
  }
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120,
              width: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xfff10627)),
              ),
              child: Center(
                child: Text(
                  "Logo",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.042,
          ),
          Text(
            widget.phoneNumber,
            style: TextStyle(
                color: Colors.black, fontSize: 21, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.042,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: PinPut(
              fieldsCount: 6,
                withCursor: true,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                showLoading(context);
                otp=pin;
                setState(() { });
                try {
                  AuthCredential credential= PhoneAuthProvider.credential(
                      verificationId: widget.verificationID, smsCode: pin);
                  await _auth
                      .signInWithCredential(credential)
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Updatepasswrd(widget.phoneNumber)),
                          (route) => false);
                    }
                  });
                } catch (e) {
                  Navigator.pop(context);
                  FocusScope.of(context).unfocus();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Invalid OTP")));
                }
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.022,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50, top: 20),
            child: _verifyButton(),
          )
        ],
      ),
    );
  }
  Widget _verifyButton() {
    return GestureDetector(
      onTap: ()async{
        if(otp!="") {
          await _controller.verifyOtp(widget.phoneNumber, otp,context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        decoration: BoxDecoration(
            color: Color(0xfff10627),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 2.0), blurRadius: 4.0, color: Colors.grey),
            ]),
        child: Center(
          child: Text(
            "Verify",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
}



