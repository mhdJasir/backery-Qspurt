import 'package:back_nw/Controller/CartControllr.dart';
import 'package:back_nw/Functions/Components.dart';
import 'package:back_nw/View/Screen/Cart/Selctaddress.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class Editaddress extends StatefulWidget {
  Map data;

  Editaddress({@required this.data});

  @override
  _EditaddressState createState() => _EditaddressState();
}

class _EditaddressState extends StateMVC<Editaddress> {
  final TextEditingController pincode = TextEditingController();
  final TextEditingController houseno = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController socity = TextEditingController();
  final TextEditingController landmrk = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  CartController _controller;

  _EditaddressState() : super(CartController()) {
    _controller = controller;
  }

  Map data;

  setData() {
    data = widget.data;
    pincode.text = data['pincode'];
    houseno.text = data['house_no'];
    city.text = data['city'];
    socity.text = data['society'];
    landmrk.text = data['landmark'];
    name.text = data['receiver_name'];
    phone.text = data['receiver_phone'];
    setState(() {});
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        moveBack(context, SelectAddress());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_rounded)),
          iconTheme: IconThemeData(color: Colors.grey[700]),
          backgroundColor: Color(0xfffafafa),
          title: Text(
            "Edit Address",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 500,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: pincode,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    cursorColor: Colors.green[700],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 1, top: 9),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green[700], width: 1.8)),
                        labelText: "Pincode*",
                        labelStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: houseno,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    cursorColor: Colors.green[700],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 1, top: 9),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green[700], width: 1.8)),
                        labelText: "House No., Building Name*",
                        labelStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: city,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          cursorColor: Colors.green[700],
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 1, top: 9),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green[700], width: 1.8)),
                              labelText: "City*",
                              labelStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: TextFormField(
                          enabled: false,
                          controller: TextEditingController(text: "Kerala"),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                          cursorColor: Colors.green[700],
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(bottom: 1, top: 9),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.green[700], width: 1.8)),
                              labelText: "State*",
                              labelStyle: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: socity,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    cursorColor: Colors.green[700],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 1, top: 9),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green[700], width: 1.8)),
                        labelText: "Society,Area,Colony*",
                        labelStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: landmrk,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    cursorColor: Colors.green[700],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 1, top: 9),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green[700], width: 1.8)),
                        labelText: "Landmark (Optional)",
                        labelStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: name,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    cursorColor: Colors.green[700],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 1, top: 9),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green[700], width: 1.8)),
                        labelText: "Name*",
                        labelStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                    cursorColor: Colors.green[700],
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 1, top: 9),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.green[700], width: 1.8)),
                        labelText: "10-digit mobile number*",
                        labelStyle: TextStyle(
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                            fontSize: 14)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Divider(
                    thickness: 1,
                    color: Colors.grey[300],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      _controller.editAddress(
                          data['address_id'],
                          name.text,
                          phone.text,
                          city.text,
                          socity.text,
                          houseno.text,
                          landmrk.text,
                          pincode.text,
                          context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 22, right: 10, left: 10, top: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 42.0,
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
                            "UPDATE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
