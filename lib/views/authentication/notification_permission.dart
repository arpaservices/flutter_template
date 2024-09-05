import 'dart:ui';

import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controllers/authetication/auth_controller.dart';
import '../../routes/app_routes.dart';
import '../../services/Firebase/firebase_config.dart';
import '../../services/localStorage/storage_utils.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/device/deviceInfo.dart';
import '../../utils/supportUI/widget_function.dart';
class NotificationPermissionScreen extends GetView<AuthController> {

  final TextEditingController mobileText = TextEditingController();
  bool isOnboardingDone = false;

  @override
  void dispose(){
    mobileText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isOnboardingDone = StorageUtils.readboolvalue(Preference.is_OnboardingComplete);
    return Scaffold(
      backgroundColor: quinary,
      body: Stack(
        children: [
          // Container(
          //   width: DeviceInfo.deviceWidth(),
          //   height: DeviceInfo.deviceHeight(),
          //   color: quinary,
          // ),
          Container(
            margin: EdgeInsets.fromLTRB(0, DeviceInfo.deviceHeight()*0.45, 0, 0),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/image/notification_bg.png"), fit: BoxFit.cover,),
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addVerticalSpace(50),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: AppTitles.notification_title + " ",
                      style: TextStyle(
                          color: dark,
                          fontWeight: FontWeight.w500,
                          fontSize: 40),
                    ),
                    TextSpan(
                      text: AppTitles.notification_title_name + " ?",
                      style: const TextStyle(
                          color: purple,
                          fontWeight: FontWeight.w500,
                          fontSize: 50),
                    ),
                  ]),
                  textAlign: TextAlign.center,
                ),
                addVerticalSpace(20),
                Text(
                  AppTitles.notificationSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: dark,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
                Spacer(),
                SizedBox(
                  width: DeviceInfo.deviceWidth()*0.8,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      FirebaseConfig config = FirebaseConfig();
                      bool isSetUp = await config.checkUpNotification();
                      if (!isSetUp) {
                        openAppSettings();
                      }
                      isOnboardingDone ? Get.back() : Get.toNamed(AppRoutes.HOME);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          primary),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Enable Notification",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: dark
                        ),
                      ),
                    ),
                  ),),
                addVerticalSpace(10),
                SizedBox(
                  width: DeviceInfo.deviceWidth()*0.45,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      isOnboardingDone ? Get.back() : Get.toNamed(AppRoutes.HOME);
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          purple),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "NO THANKS",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: quinary
                        ),
                      ),
                    ),
                  ),
                ),

                addVerticalSpace(20),
              ],
            ),
          ),
        ],
      ),
    );
  }

}