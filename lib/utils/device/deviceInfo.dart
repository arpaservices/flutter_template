

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

class DeviceInfo {
  static double deviceHeight() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    double physicalHeight = view.physicalSize.height;
    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    // print("screenHeight " + screenHeight.toString());
    return screenHeight;
  }

  static double deviceWidth() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    double physicalWidth = view.physicalSize.width;
    double devicePixelRatio = view.devicePixelRatio;
    double screenWidth = physicalWidth / devicePixelRatio;
    // print("screenWidth " + screenWidth.toString());
    return screenWidth;
  }
}