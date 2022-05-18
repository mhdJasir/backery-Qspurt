




  import 'package:shared_preferences/shared_preferences.dart';

class Preferences  {


 static setAppIcon(appLogo)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('appIcon', appLogo);
  }
 static Future<String> getAppIcon()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get('appIcon');
 }

 static setCartData(gTotal)async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('grantTotal', "$gTotal");
 }
 static Future<String> getTotal()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
  return  prefs.getString('grantTotal');
 }
  }