import 'package:back_nw/Controller/UserLogRegController.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/View/Bottomtabs.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:back_nw/View/Loginpge/ForgotPass.dart';
import 'package:back_nw/View/Loginpge/Register.dart';
import 'package:back_nw/View/Widgets/Style.dart';
import 'package:back_nw/View/Widgets/validate_Fields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

TextEditingController _phonecontroller = TextEditingController();
TextEditingController _passwrodcontroller = TextEditingController();
bool isLogin = false;

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends StateMVC<SignIn> {
  UserLogRegController _con;

  _SignInState() : super(UserLogRegController()) {
    _con = controller;
  }

  bool autoValidate = false;
  Validations validations = new Validations();

  submit() async {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
      autoValidate = true;
    } else {
      form.save();
      _con.signIn(_phonecontroller.text, _passwrodcontroller.text, context);
    }
  }

  Widget loginButton() {
    return GestureDetector(
      onTap: submit,
      child: Padding(
        padding: const EdgeInsets.only(right: 2, left: 2),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 45.0,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(1.0, 1.0),
                    spreadRadius: 1.3,
                    blurRadius: 2.5,
                    color: Colors.grey[300])
              ]),
          child: Center(
            child: Text(
              "Sign In",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _Password() {
    return Padding(
      padding: const EdgeInsets.only(right: 2, left: 2),
      child: TextFormField(
        keyboardType: TextInputType.text,
        validator: validations.validatePassword,
        controller: _passwrodcontroller,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        autofillHints: [AutofillHints.password],
        onEditingComplete: () => TextInput.finishAutofillContext(),
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

  Widget _mobilefield() {
    return Padding(
      padding: const EdgeInsets.only(right: 2, left: 2),
      child: TextFormField(
        keyboardType: TextInputType.number,
        validator: validations.validateMobile,
        controller: _phonecontroller,
        style: TextStyle(
            color: Colors.grey[900], fontWeight: FontWeight.w500, fontSize: 15),
        autofillHints: [AutofillHints.telephoneNumberNational],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Form(
                key: _con.loginFormKey,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.0552,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 120,
                            width: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Color(0xfff10627)),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: appLogo,
                            )),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text("Sign In", style: f18B6),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          "Please enter your credentials",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      AutofillGroup(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            _mobilefield(),
                            SizedBox(
                              height: 20,
                            ),
                            _Password(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      loginButton(),
                      SizedBox(
                        height: 27,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Forgotpasswrd()));
                        },
                        child: Center(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New User? ",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 15),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                              print("Signup");
                            },
                            child: Text(
                              "Please SignUp",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Bottomtabs()));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
}
