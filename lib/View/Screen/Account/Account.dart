import 'package:back_nw/Controller/ProfileController.dart';
import 'package:back_nw/Model/Loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Account extends StatefulWidget {


  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final name = TextEditingController();

  final phone = TextEditingController();

  final email = TextEditingController();

  final profileController=Get.put(ProfileController());
  bool loading=true;
  setFields()async{
   await profileController.getProfileData().then((value){
      name.text=profileController.profileData['user_name'];
      email.text=profileController.profileData['user_email'];
      phone.text=profileController.profileData['user_phone'];
    });
    loading=false;
    setState(() {});
  }
 @override
  void initState() {
   setFields();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading?
      Center(child: CircularProgressIndicator()):
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                color: Color(0xfff10627),
                child: Center(
                    child: Icon(
                  Icons.account_circle,
                  size: 144,
                  color: Colors.white,
                )),
              ),
              SizedBox(
                height: 55,
              ),
              _username(),
              SizedBox(
                height: 19,
              ),
              _mobileField(),
              SizedBox(
                height: 19,
              ),
              _emailField(),
              SizedBox(
                height: 39,
              ),
              _saveButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _username() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Container(
        height: 42,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 0.1), blurRadius: 2.0, color: Colors.grey)
            ]),
        child: TextFormField(
          controller: name,
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.start,
          cursorColor: Color(0xfff10627),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 2, top: 8),
              prefixIcon: Icon(
                Icons.person,
                color: Color(0xfff10627),
                size: 22,
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _emailField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 0.1), blurRadius: 2.0, color: Colors.grey)
            ]),
        child: TextFormField(
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
          controller: email,
          keyboardType: TextInputType.emailAddress,
          textAlign: TextAlign.start,
          cursorColor: Color(0xfff10627),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email,
                color: Color(0xfff10627),
                size: 22,
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _mobileField() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 0.1), blurRadius: 2.0, color: Colors.grey)
            ]),
        child: TextFormField(
          controller: phone,
          style: TextStyle(
              fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.start,
          cursorColor: Color(0xfff10627),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.phone_android_rounded,
                color: Color(0xfff10627),
                size: 22,
              ),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return GestureDetector(
      onTap: () async{
        showLoading(context);
       await profileController.editProfile(name.text, email.text, phone.text);
       Navigator.pop(context);
      },
      child: Container(
        width: 250,
        height: 45.0,
        decoration: BoxDecoration(
            color: Color(0xfff10627),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 1.0),
                  blurRadius: 2.0,
                  color: Colors.grey),
            ]),
        child: Center(
          child: Text(
            "SAVE",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
