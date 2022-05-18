

import 'package:back_nw/Utils/Shared_Prefs.dart';
import 'package:back_nw/View/GlobalVar.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:back_nw/Repository/BottomtabsReposi.dart'as repo;
class BottomController extends ControllerMVC{

List pordrdetails,pastorder;


var userid;
void pendingordr()async{
    print("LLLLL");

   repo.pndingodr(USERID).then((value) {
      print("zz" +value.toString());
      setState(() {
        pordrdetails = value;
      });

        print("Finallll"+pordrdetails.toString());
       print(pordrdetails[0]["order_status"]);
      print(pordrdetails[0]["time_slot"]);

      }
    );


  }
void pasorder()async{


  repo.pstorder(USERID).then((value) {
    print("ANA" +value.toString());
    setState(() {
      pastorder = value;
    });

    print("Finallll"+pastorder.toString());
    print(pastorder[0]["order_status"]);
    print(pastorder[0]["time_slot"]);

  }
  );


}

}