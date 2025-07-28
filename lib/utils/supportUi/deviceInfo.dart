import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../../data/enums/users/device_type.dart';





class DeviceInfo {
  static double deviceHeight() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    double physicalHeight = view.physicalSize.height;
    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    // print("screenHeight " + screenHeight.toString());
    return screenHeight;
  }

  static DeviceType getDeviceType() {
    if (Platform.isAndroid) {
      return DeviceType.android;
    } else if (Platform.isIOS) {
      return DeviceType.ios;
    } else {
      return DeviceType.android;
    }
  }

  static double deviceWidth() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    double physicalWidth = view.physicalSize.width;
    double devicePixelRatio = view.devicePixelRatio;
    double screenWidth = physicalWidth / devicePixelRatio;
    // print("screenWidth " + screenWidth.toString());
    return screenWidth;
  }

  static double COMMAN_TOP_PADDING = 40.0;
  static double COMMAN_HORIZONTAL_PADDING = 10.0;
}
