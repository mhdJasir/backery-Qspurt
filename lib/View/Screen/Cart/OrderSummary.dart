import 'package:back_nw/Controller/CartControllr.dart';
import 'package:back_nw/Model/CartModel.dart';
import 'package:back_nw/Utils/NetworkUtils.dart';
import 'package:back_nw/Utils/Preferences.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:back_nw/View/Screen/Cart/Checkout.dart';
import 'package:back_nw/View/Screen/Cart/Selctaddress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:horizontal_calendar_widget/horizontal_calendar.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../../Model/DatabaseHelper.dart';

class OrderSummary extends StatefulWidget {
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends StateMVC<OrderSummary> {
  CartController _con;

  _OrderSummaryState() : super(CartController()) {
    _con = controller;
  }

  var selectedDate;
  int bottomRadioValue = 0;

  selectedTextStyle(double font) =>
      TextStyle(color: Colors.white, fontSize: font);
  List<CartModel> product;
  final dbHelper = DatabaseHelper.instance;
  var total = "0";
  bool loading = false;

  Future getData() async {
    product = await dbHelper.getProducts();
    total = await Preferences.getTotal();
    deliveryCharge = await _con.getMinOrderValue();
  }

  bool primaryLoading = true;

  @override
  void initState() {
    super.initState();
    getData().then((value) {
      primaryLoading = false;
      setState(() {});
    });
    setState(() {
      selectedDate = getDateFormatted(DateTime.now());
    });
    _con.timeSlot(selectedDate);
  }

  getDateFormatted(DateTime date) {
    final serverFormatter = DateFormat('yyyy-MM-dd');
    final formatted = serverFormatter.format(date);
    return formatted;
  }

  var deliveryCharge;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
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
            "Order Summary",
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        body: primaryLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.all(6),
                          height: 230,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                offset: Offset(0.0, 1.0),
                                blurRadius: 2.0,
                                color: Colors.grey),
                          ]),
                          child: Column(children: [
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 5),
                              child: userAddress != null &&
                                      userAddress.length != 0
                                  ? Padding(
                                      padding: const EdgeInsets.only(top: 3),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(userAddress[0].name,
                                              style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${userAddress[0].city}" +
                                                ",  " +
                                                "${userAddress[0].state}" +
                                                ", "
                                                    "${userAddress[0].pinCode}",
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text("${userAddress[0].number}",
                                              style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14)),
                                          SizedBox(
                                            height: 16,
                                          ),
                                        ],
                                      ),
                                    )
                                  : Text(
                                      "Add delivery address here..",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3, right: 4),
                              child: Container(
                                padding: EdgeInsets.only(left: 3),
                                decoration: BoxDecoration(
                                    color: Color(0xfffdf6e3),
                                    border: Border.all(
                                        color: Color(0xffede0bd), width: 3)),
                                child: Text(
                                    "Please make sure this address is suitable to collect your grocery order"),
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.042,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SelectAddress()));
                              },
                              child: Container(
                                width: 300,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    color: Color(0xfff10627),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0.0, 0.3),
                                          blurRadius: 2.0,
                                          color: Colors.grey),
                                    ]),
                                child: Center(
                                  child: Text(
                                    "Change or Add Address",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          "Basket items (" + product.length.toString() + ")",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        height: 90,
                        child: new ListView(
                          scrollDirection: Axis.horizontal,
                          children: product.map((element) {
                            return new Padding(
                              padding: const EdgeInsets.only(top: 1, left: 10),
                              child: Transform.scale(
                                scale: 0.8,
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl + element.varient_image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          "\u20B9 " + total,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Choose a Delivery Slot",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: HorizontalCalendar(
                          onDateSelected: (date) async {
                            _con.loading = true;
                            _con.timeslotlist = [];
                            setState(() {});
                            selectedDate = getDateFormatted(date);
                            setState(() {});
                            await _con.timeSlot(selectedDate);
                          },
                          height: 110,
                          padding: EdgeInsets.all(22),
                          firstDate: DateTime.now(),
                          initialSelectedDates: [DateTime.now()],
                          lastDate: DateTime.now().add(Duration(days: 10)),
                          dateTextStyle: TextStyle(fontSize: 22),
                          selectedDecoration: BoxDecoration(
                              color: Colors.green[500],
                              borderRadius: BorderRadius.circular(8)),
                          selectedDateTextStyle: selectedTextStyle(22),
                          selectedMonthTextStyle: selectedTextStyle(16),
                          selectedWeekDayTextStyle: selectedTextStyle(16),
                          maxSelectedDateCount: 1,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Stack(
                        children: [
                          !_con.loading
                              ? _con.timeslotlist.length == 0
                                  ? Container(
                                      color: Colors.grey[100],
                                      height: 190,
                                      child: Center(
                                          child: Text(
                                        "No time slot available for $selectedDate",
                                        style: TextStyle(color: Colors.red),
                                      )),
                                    )
                                  : Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 190,
                                      color: Colors.grey[100],
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 1),
                                        child: Container(
                                          height: 52,
                                          child: ListView.builder(
                                            itemCount: _con.timeslotlist.length,
                                            itemBuilder: (context, index) {
                                              return RadioListTile(
                                                value: index,
                                                groupValue: bottomRadioValue,
                                                onChanged: (value) {
                                                  setState(() {
                                                    bottomRadioValue = value;
                                                  });
                                                },
                                                title: Text(
                                                    _con.timeslotlist[index],
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            bottomRadioValue ==
                                                                    index
                                                                ? Color(
                                                                    0xfffa8003)
                                                                : Colors.grey[
                                                                    500])),
                                                secondary: Text("available",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color:
                                                            bottomRadioValue ==
                                                                    index
                                                                ? Color(
                                                                    0xfffa8003)
                                                                : Colors.grey[
                                                                    500])),
                                                activeColor: Colors.green,
                                              );
                                            },
                                          ),
                                        ),
                                      ))
                              : Container(
                                  color: Colors.grey[100],
                                  height: 190,
                                  child: Center(
                                      child: CupertinoActivityIndicator())),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "\u20B9 ${deliveryCharge == null ? 0 : deliveryCharge}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Price Details",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: total == null || deliveryCharge == null
                          ? Container()
                          : Text(
                              "\u20B9 ${int.parse(total) + deliveryCharge}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7, top: 6, bottom: 3),
                child: GestureDetector(
                  onTap: () async {
                    if (_con.timeslotlist.length == 0) {
                      Fluttertoast.showToast(msg: 'Please chose a time slot');
                    } else {
                      loading = true;
                      setState(() {});
                      List list = [];
                      for (var i in product) {
                        var model = {"varient_id": i.varient_id, "qty": i.unit};
                        list.add(model);
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Checkout(
                            price: (int.parse(total) + deliveryCharge ?? 0)
                                .toString(),
                          ),
                        ),
                      );
                    }
                    loading = false;
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    color: Color(0xfff10627),
                    child: Center(
                      child: Text(
                        "CONTINUE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
