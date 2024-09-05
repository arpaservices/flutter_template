
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/device/deviceInfo.dart';
import '../../utils/supportUI/widget_function.dart';

class SplashScreen extends GetView<SplashController> {
  Widget build(BuildContext context) {
    controller.startTimerForSplash();
    return Scaffold(
      backgroundColor: primary_bg_blue,
      body: Stack(
        children: [
          Container(
            width: DeviceInfo.deviceWidth(),
            height: DeviceInfo.deviceHeight(),
            color: primary_bg_blue,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(DeviceInfo.deviceHeight()*0.35),
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    "assets/image/splash_logo_sticker.png",
                  ),
                ),
                const Spacer(),

                addVerticalSpace(50)
              ],
            ),
          )
        ],
      ),

    );
  }

}