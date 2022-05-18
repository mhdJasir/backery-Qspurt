


import 'package:device_info/device_info.dart';

var deviceId;

getDeviceId()async{
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  var androidDeviceInfo = await deviceInfoPlugin.androidInfo;
  deviceId =  androidDeviceInfo.androidId;
}


