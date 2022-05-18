import 'package:back_nw/Controller/UserLogRegController.dart';
import 'package:back_nw/Utils/Preferences.dart';
import 'package:back_nw/View/Bottomtabs.dart';
import 'package:back_nw/View/Loginpge/Login.dart';
import 'package:back_nw/View/Widgets/Style.dart';
import 'package:back_nw/View/Widgets/validate_Fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

var datauser;

class _SignUpState extends StateMVC<SignUp> {
  UserLogRegController _con;

  _SignUpState() : super(UserLogRegController()) {
    _con = controller;
  }

  final TextEditingController username = TextEditingController();
  final TextEditingController mobilenumber = TextEditingController();
  final TextEditingController emailid = TextEditingController();
  final TextEditingController password = TextEditingController();

  Validations validations = Validations();
String appIcon;
  var autovalidate;
  getAppIcon()async{
    appIcon=await Preferences.getAppIcon();
    setState(() { });
  }
  @override
  void initState() {
    getAppIcon();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 120,
                          width: 130,
                          decoration: BoxDecoration(
                          ),
                          child: CachedNetworkImage(
                            imageUrl: appIcon,
                            errorWidget: (c,e,_){
                              return Center(child: Icon(Icons.error));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text("Sign Up", style: f18B6),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please enter your credentials",
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      _username(),
                      SizedBox(
                        height: 19,
                      ),
                      _mobilefield(),
                      SizedBox(
                        height: 19,
                      ),
                      _emailfield(),
                      SizedBox(
                        height: 19,
                      ),
                      _Password(),
                      SizedBox(
                        height: 19,
                      ),
                      _SignupBtn(),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn()));
                        },
                        child: Center(
                          child: Text(
                            "Already Registered? Login",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Bottomtabs()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Skip",
                style: TextStyle(
                    color: Color(0xfff10627),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: Color(0xfff10627),
              )
            ],
          ),
        ),
      ),
    );
  }
  submit() async {
    final FormState form = _con.loginFormKey.currentState;
    if (form.validate()) {
      form.save();
      _con.signup(username.text, mobilenumber.text, emailid.text, password.text,
          context);
    }
  }

  Widget _Password() {
    return Padding(
      padding: EdgeInsets.only(right: 2, left: 2),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: validations.validatePassword,
        controller: password,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _SignupBtn() {
    return GestureDetector(
      onTap: () {
        submit();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        decoration: BoxDecoration(
            color: Color(0xfff10627),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 4.0,
                  color: Colors.grey),
            ]),
        child: Center(
          child: Text(
            "SIGN UP",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _mobilefield() {
    return Padding(
      padding: const EdgeInsets.only(right: 2, left: 2),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: validations.validateMobile,
        controller: mobilenumber,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          hintText: "Phone Number",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.only(right: 2, left: 2),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: validations.validateName,
        controller: username,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          hintText: "Enter User Name",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _emailfield() {
    return Padding(
      padding: const EdgeInsets.only(right: 2, left: 2),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: validations.validateEmail,
        controller: emailid,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400]),
              borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          hintText: "Enter Email ID",
          hintStyle: TextStyle(fontSize: 16, color: Colors.grey[500]),
          border: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

}
