import 'package:back_nw/Controller/CartControllr.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:back_nw/View/Screen/Cart/Addaddress.dart';
import 'package:back_nw/View/Screen/Cart/Editaddress.dart';
import 'package:back_nw/View/Screen/Cart/OrderSummary.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SelectAddress extends StatefulWidget {
  @override
  _SelectAddressState createState() => _SelectAddressState();
}

class _SelectAddressState extends StateMVC<SelectAddress> {
  CartController _con;

  _SelectAddressState() : super(CartController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.viewAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        backgroundColor: Color(0xfffafafa),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded)),
        title: Text(
          "Select Address",
          style: TextStyle(color: Colors.grey[700]),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AddAddress()));
              },
              contentPadding: EdgeInsets.only(left: 20),
              leading: Icon(
                Icons.add_circle_outline,
                color: Color(0xfff10627),
              ),
              title: Align(
                alignment: Alignment(-1.2, 0),
                child: Text(
                  "Add a new address",
                  style: TextStyle(
                      color: Color(0xfff10627),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[500],
                      ),
                  itemCount: _con.viewAddresses != null
                      ? _con.viewAddresses.length
                      : 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        userAddress = [];
                        AddressModel model = AddressModel(
                          _con.viewAddresses[index]["city"],
                          _con.viewAddresses[index]["receiver_name"],
                          _con.viewAddresses[index]["receiver_phone"],
                          _con.viewAddresses[index]["pincode"],
                          _con.viewAddresses[index]["state"],
                        );
                        userAddress.add(model);
                        setState(() {});
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderSummary()));
                      },
                      child: ListTile(
                        trailing: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (c) {
                                return Editaddress(
                                  data: _con.viewAddresses[index],
                                );
                              }));
                            },
                            child: Icon(Icons.edit_outlined)),
                        // leading: Radio(value: null, groupValue: selectedRadioTile, onChanged: ),
                        title: Text(
                          _con.viewAddresses[index]["receiver_name"],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 5,
                            ),
                            Text(_con.viewAddresses[index]["receiver_phone"]),
                            Text(_con.viewAddresses[index]["receiver_name"] +
                                " " +
                                _con.viewAddresses[index]["city"] +
                                " " +
                                _con.viewAddresses[index]["state"] +
                                " " +
                                _con.viewAddresses[index]["pincode"])
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressModel {
  String name;
  String number;
  String city;
  String state;
  String pinCode;

  AddressModel(this.city, this.name, this.number, this.pinCode, this.state);
}
