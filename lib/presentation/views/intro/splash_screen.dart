import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/core/constant/assets.dart';
import '../../../utils/core/constant/constants.dart';
import '../../controllers/intro/splash_screen_controller.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.splashScreenLogic();
    return Scaffold(
     // backgroundColor: colorBlack,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              Assets.getPNGImage("splash_background.png"),
              fit: BoxFit.cover,
            ),
          ),

          // Centered App Icon & Name using Stack
          Positioned.fill(
            child: Center(
              child: Stack(
                alignment:
                    Alignment.bottomCenter, // Align text at bottom of the logo
                children: [
                  // App Icon
                  Image.asset(
                    Assets.getAppSettings('splash_logo_image.png'),
                    height: 290, // Adjust size
                    width: 290,
                  ),

                  // App Name placed inside the logo at the bottom
                  Positioned(
                    bottom: 10, // Adjust text positioning inside the logo
                    child: Text(
                      Constants.APP_NAME,
                      //AppLocalizations.of(context)!.splashAppName,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                       // color: colorWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
