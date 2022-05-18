import 'package:back_nw/Controller/CartControllr.dart';
import 'package:back_nw/Functions/Components.dart';
import 'package:back_nw/View/Screen/Cart/AddressMappage.dart';
import 'package:back_nw/View/Screen/Cart/Selctaddress.dart';
import 'package:back_nw/View/Widgets/validate_Fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends StateMVC<AddAddress> {
  CartController _con;
  _AddAddressState() : super(CartController()) {
    _con = controller;
  }

  final TextEditingController pin = TextEditingController();
  final TextEditingController houseno = TextEditingController();
  final TextEditingController socity = TextEditingController();
  final TextEditingController landmrk = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();



  Validations validations = new Validations();
 _submit(context) async {
    final FormState form = _con.loginFormKey.currentState;
    if (!form.validate()) {
    }
    else {
      form.save();
      _con.addadress(pin.text,houseno.text,socity.text,landmrk.text,name.text,phone.text,context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        moveBack(context, SelectAddress());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(elevation: 1,
          leading: GestureDetector(
              onTap: (){Navigator.pop(context);},
              child: Icon(Icons.arrow_back_ios_rounded)),
          iconTheme: IconThemeData(color:  Colors.grey[700]),
          backgroundColor: Color(0xfffafafa),
          title: Text("Add Address",style: TextStyle(color:  Colors.grey[700]),),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: _con.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15,top: 10),
                    child: Container(
                      child: TextFormField(
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        validator: validations.validateField,
                        maxLength: 6,
                        controller: pin,
                        // focusNode: _myfocusnode,
                        cursorColor: Colors.green[700],
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(counterText: "",
                          focusedBorder: UnderlineInputBorder(
                              borderSide:BorderSide(color: Colors.green[700],width: 1.8) ),
                            contentPadding: EdgeInsets.only(bottom:1,top: 9),
                            labelText: "Pincode*",
                            labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    child: Container(
                      child: TextFormField(
                        validator: validations.validateField,
                        controller: houseno,
                        cursorColor: Colors.green[700],
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:BorderSide(color: Colors.green[700],width: 1.8) ),
                            contentPadding: EdgeInsets.only(bottom:1,top: 9),
                            labelText: "House No., Building Name*",
                            labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    child: Container(
                      child: TextFormField(
                        validator: validations.validateField,
                        controller: socity,
                        cursorColor: Colors.green[700],
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:BorderSide(color: Colors.green[700],width: 1.8) ),
                            contentPadding: EdgeInsets.only(bottom:1,top: 9),
                            labelText: "Society, Area, Colony*",
                            labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5,left: 15,right: 15,top: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        width: 150,
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("State*",style:TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,fontSize: 10),) ,
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text("Kerala",style:TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 15),),
                            ) ,
                            Divider(color: Colors.grey[900],)
                          ],
                        ) ,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5,left: 15,right: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressMappage()));
                        },
                        child: Container(
                          width: 150,
                          height: 35.0,
                          decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(
                                        1.0,
                                        1.0
                                    ),
                                    blurRadius: 3.0,
                                    color: Colors.grey
                                ),
                              ]
                          ),
                          child: Center(
                            child: Text ("Location",style: TextStyle(
                                color: Color(0xfff10627),
                                fontSize: 16,fontWeight: FontWeight.w600
                            ),),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    child: Container(
                      child: TextFormField(
                        validator: validations.validateField,
                        controller: landmrk,
                        cursorColor: Colors.green[700],
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:BorderSide(color: Colors.green[700],width: 1.8) ),

                            contentPadding: EdgeInsets.only(bottom:1,top: 9),

                            labelText: "Landmark*",
                            labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.grey[300],),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    child: Container(
                      child: TextFormField(
                        validator: validations.validateField,
                        controller: name,
                        cursorColor: Colors.green[700],
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide:BorderSide(color: Colors.green[700],width: 1.8) ),

                            contentPadding: EdgeInsets.only(bottom:1,top: 9),
                            labelText: "Name*",
                            labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10,left: 15,right: 15),
                    child: Container(
                      child: TextFormField(
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        validator: validations.validateMobile,
                        maxLength: 10,
                        controller: phone,
                        cursorColor: Colors.green[700],
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: "",
                            focusedBorder: UnderlineInputBorder(
                                borderSide:BorderSide(color: Colors.green[700],width: 1.8) ),
                            contentPadding: EdgeInsets.only(bottom:1,top: 9),
                            labelText: "10-digit mobile number*",
                            labelStyle: TextStyle(color: Colors.grey[500],fontWeight: FontWeight.w500,fontSize: 14)
                        ),
                      ),
                    ),
                  ),
                  Divider(thickness: 1,color: Colors.grey[300],),

                ],
              ),
            )
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: (){
            _submit(context);
          },
          child: Padding(
            padding:  EdgeInsets.only(bottom: 22,right: 10,left: 10),
            child: Container(
              width: 150,
              height: 42.0,
              decoration: BoxDecoration(
                  color: Color(0xfff10627),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(
                            0.0,
                            1.0
                        ),
                        blurRadius: 2.0,
                        color: Colors.grey
                    ),
                  ]
              ),
              child: Center(
                child: Text ("SAVE",style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,fontWeight: FontWeight.w600
                ),),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
