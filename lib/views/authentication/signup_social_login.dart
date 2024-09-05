import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/authetication/signup_social_login_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/device/deviceInfo.dart';
import '../../utils/supportUi/widget_function.dart';

class SignUpSocialLoginScreen extends GetView<SignUpSocialLoginController> {
  SignUpSocialLoginScreen({super.key});

  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop:  false,
      child: Scaffold(
        backgroundColor: primary_bg_blue,
        body: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.fromLTRB(0, DeviceInfo.deviceHeight() * 0.15, 0, 0),
              decoration: const BoxDecoration(
                // image: DecorationImage(image: AssetImage("assets/image/signup_bg.png"), fit: BoxFit.cover,),
                image: DecorationImage(
                  image: AssetImage("assets/image/cloudy_bg.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      "assets/image/splash_logo_sticker.png",
                    ),
                  ),
                  getPPHattonText(AppTitles.app_name, TextAlign.center, dark, FontWeight.w500, 60),
                  // getNewFontText(AppTitles.app_subtitle, TextAlign.center, dark, FontWeight.w500, 15),
                  addVerticalSpace(50),
                  const Text(
                    AppTitles.app_journey_title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: dark,
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                  ),
                  addVerticalSpace(25),
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        const ButtonSelector(
                          text: "Google",
                          icon: "assets/image/google_icon.png",
                          weight: 20,
                          height: 20,
                          backColor: dark,
                          txtColor: quinary,
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              controller.signUpWithGmailAndApplePressed(
                                  Preference.is_GoogleSignIn, context);
                            }),
                      ],
                    ),
                  ),
                  addVerticalSpace(25),
                  SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        const ButtonSelector(
                          text: "Mobile",
                          icon: "assets/image/phone_icon.png",
                          weight: 20.0,
                          height: 20,
                          backColor: quinary,
                          txtColor: dark,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            controller.signUpWithMobile();
                                                    },
                        ),
                      ],
                    ),
                  ),
                  // Platform.isAndroid ? addVerticalSpace(25) : addVerticalSpace(60),
                  addVerticalSpace(25),

                  // Platform.isAndroid
                  //     ? addVerticalSpace(60)
                  //     : addVerticalSpace(25),
                  if (Platform.isIOS)
                    SizedBox(
                      height: 50,
                      child: Stack(
                        children: [
                          const ButtonSelector(
                            text: "Apple",
                            icon: "assets/image/apple_icon.png",
                            weight: 20,
                            height: 20,
                            backColor: dark,
                            txtColor: quinary,
                          ),
                          GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                controller.signUpWithGmailAndApplePressed(
                                    Preference.is_AppleSignIn, context);
                              }),
                        ],
                      ),
                    ),
                  if (Platform.isIOS) addVerticalSpace(60),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(
                        text: "${AppTitles.termsAndConditionMsg} ",
                        style: TextStyle(
                            color: dark,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      TextSpan(
                        text: AppTitles.termsAndCondition,
                        style: const TextStyle(
                            color: linkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await controller.launchWebsite(
                                AppTitles.termsAndConditionUrl);
                          },
                      ),
                     const TextSpan(
                        text: '  and  ',
                        style: TextStyle(
                            color: dark,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      TextSpan(
                        text: AppTitles.privacyPolicy,
                        style:const TextStyle(
                            color: linkColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            await controller
                                .launchWebsite(AppUrls.privacyPolicyUrl);
                          },
                      )
                    ]),
                    textAlign: TextAlign.center,
                  ),
                  addVerticalSpace(50),
                ],
              ),
              // child: Scrollbar(
              //   thumbVisibility: false,
              //
              // ),
            )
          ],
        ),
      ),
    );
  }
}
