
import 'package:back_nw/View/GlobalVar.dart';
import 'package:back_nw/View/Loginpge/Login.dart';
import 'package:back_nw/View/Screen/About.dart';
import 'package:back_nw/View/Screen/Account/Account.dart';
import 'package:back_nw/View/Screen/Cart/Cart.dart';
import 'package:back_nw/View/Screen/Home/Homepg.dart';
import 'package:back_nw/View/Screen/Home/Myorder/Myorder.dart';
import 'package:back_nw/View/Screen/Search/Search.dart';
import 'package:back_nw/View/Screen/TermCondtn.dart';
import 'package:back_nw/View/Widgets/Style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets/GoogleMap.dart';



class Bottomtabs extends StatefulWidget {
  @override
  _BottomtabsState createState() => _BottomtabsState();
}

class _BottomtabsState extends State<Bottomtabs> {

  int _currentindex = 0 ;
  final List<Widget> _children = [
    Home(),
    Search(),
    Cart(),
    Account()

  ];
  void onTappedBar(int index)
  {
    setState(() {
      _currentindex = index;
    });
  }

  String usrname;

  @override
  void initState() {
    super.initState();
    // getUserLocation();
    getusername();

  }

  void getusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      usrname=  prefs.getString("userName");
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Container(
          child: TextButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (c){
                return GoogleMapWidget();
              }));
            },
            child: Text(address==null?"":address,maxLines: 2,
              style: TextStyle(fontSize: 12,color: Colors.grey[700]),textAlign: TextAlign.justify,),
          ),
        ),
        backgroundColor: Color(0xfffafafa),
        leading: Builder(
          builder: (context)=> IconButton(
              icon:Icon(Icons.menu,color: Colors.black87,size: 30,),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 9),
            child: GestureDetector(
                onTap: (){

                },
                child: Icon(Icons.account_circle,color: Colors.black87,size: 30,)),
          )
          ],

      ),
        body:_children[_currentindex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: onTappedBar,
            currentIndex: _currentindex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                  label: "HOME",
                  activeIcon: Icon(Icons.home,size: 26.0,),
                  icon: Icon(Icons.home,size: 25.0,),
                  backgroundColor: Color(0xfff01d3a)),
              BottomNavigationBarItem(
                  label: "SEARCH",
                  activeIcon: Icon(Icons.search_rounded,size: 24.0,),
                  icon: Icon(Icons.search_rounded,size: 25.0,),
                  backgroundColor: Color(0xfff01d3a)),
              BottomNavigationBarItem(
                  label: "CART",
                  activeIcon: Icon(Icons.shopping_bag_outlined,size: 26.0,),
                  icon: Icon(Icons.shopping_bag_outlined, size: 25.0,),
                  backgroundColor: Color(0xfff01d3a)),
              BottomNavigationBarItem(
                  label: "ACCOUNT",
                  activeIcon: Icon(Icons.person_outline ,size: 26.0,),
                  icon: Icon(Icons.person_outline,size: 25.0, ),
                  backgroundColor: Color(0xfff01d3a)),

            ]),
        drawer: Drawer(
          child: Container(
            color: Colors.black,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration:BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey[700],
                                    spreadRadius: 2,blurRadius: 3
                                )
                              ]
                          ),

                          child: CircleAvatar(
                            backgroundColor: Color(0xfff01d3a),
                            backgroundImage: AssetImage("assets/images/cn.png"),
                            radius: 22,

                          ),
                        ),
                        Text(usrname==null?"Hey User":usrname,style: TextStyle(
                          color: Colors.white,fontSize: 18,
                        ),),

                        Icon(Icons.arrow_forward_ios_rounded,size: 18,color: Colors.white,)
                      ],
                    )
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  height: 80,
                  color:Color(0xfff01d3a),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20,left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: (){
                            print("Order");
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Myorder()));
                          },
                          child: Column(children: [
                            Icon(Icons.menu,color: Colors.white,),
                            Text("My Order",style: f16Wyt,)
                          ],),
                        ),
                        GestureDetector(
                          onTap: (){

                          },
                          child: Column(children: [
                            Icon(Icons.shopping_cart,color: Colors.white,),
                            Text("Cart",style: f16Wyt,)
                          ],),
                        ),

                      ],),
                  ),
                ),

                ListTile(
                  onTap: ()async{
                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    usrname==null? Navigator.pop(context):
                    prefs.clear();

                    FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) =>SignIn()
                    ), (route) => false);
                    setState(() {
                      usrname ="";

                    });
                  },
                  title: Text(usrname==null?"Login/Signup":"Log Out",style: f16Wyt),
                  leading: Icon(usrname==null?Icons.home_rounded:Icons.logout,color: Colors.white54,size: 27,),
                ),

                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));
                  },
                  title: Text("About Us",style: f16Wyt),
                  leading: Icon(Icons.person,color: Colors.white54,size: 27,),
                ),
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TermConditn()));
                  },
                  title: Text("Term & Privacy",style: f16Wyt),
                  leading: Icon(Icons.assignment_turned_in_outlined,color: Colors.white54,size: 27,),
                ),

              ],
            ),
          ),
        )

    );
  }

}
