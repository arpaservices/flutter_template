import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../controllers/authetication/otp_verification_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/supportUI/widget_function.dart';
import '../../utils/supportUi/deviceInfo.dart';
import '../../widgets/comman_dialog.dart';

/*
class VerificationScreen extends GetView<AuthController> {

  late String _verificationId = "123456";
  final TextEditingController _codeController  = TextEditingController();
  final AuthController authController = Get.find();
  VerificationScreen({super.key});

  @override
  void initState() {
    _verificationId = Get.arguments['verificationId'];
  }

  @override
  void dispose(){
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //controller.callAuthenticateAPI(NetworkConstantSuperApp.AUTHENTICATE);
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Verification Code'),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Scrollbar(
              thumbVisibility: false,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        hintText: 'Verification Code',
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        authController.verifyCode(_verificationId,_codeController.text);
                      },
                      child: Text('Verify'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

      ),

    );
  }


}
 */

class VerificationScreen extends GetView<OtpVerificationController> {
  late String _verificationId = "123456";
  final TextEditingController otpText  = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  // final AuthController authController = Get.find();
  VerificationScreen({super.key});
  final formKey = GlobalKey<FormState>();
  int otpLength = 6;

  @override
  void initState() {
    _verificationId = Get.arguments['verificationId'];
  }

  @override
  void dispose(){
    otpText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String countryCode = Get.arguments[AppArg.mobile_country_code];
    String mobilenum = Get.arguments[AppArg.mobile_number];

    // Future<String> validateOtp(String otp, String flag) async {
    //   return await controller.sendOtpData(otp,flag);
    // }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: dark
        ),
      ),
      backgroundColor: quinary,
      body: Stack(
        children: [
          Container(
            width: DeviceInfo.deviceWidth(),
            height: DeviceInfo.deviceHeight(),
            color: quinary,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Obx(() => SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  addVerticalSpace(DeviceInfo.deviceHeight()*0.1),
                  // Text(
                  //   AppTitles.otp_mobile_title,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       color: dark,fontWeight: FontWeight.w700,fontSize: 25
                  //   ),
                  // ),
                  getPPHattonText(AppTitles.otp_mobile_title, TextAlign.center, dark, FontWeight.w700, 30),
                  addVerticalSpace(20),
                  Text(
                    AppTitles.otp_mobile_subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Text(
                    countryCode + " " + mobilenum,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  addVerticalSpace(20),
                  Form(
                    key: formKey,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 30),
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle: TextStyle(
                            fontSize: 18,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                          length: otpLength,
                          // obscureText: true,
                          // obscuringCharacter: '*',
                          // blinkWhenObscuring: true,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            inactiveColor: Colors.grey.shade100,
                            inactiveFillColor: primary.withOpacity(0.3),
                          ),
                          cursorColor: primary,
                          animationDuration: Duration(milliseconds: 300),
                          enableActiveFill: true,
                          errorAnimationController: errorController,
                          controller: otpText,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: dark,
                              blurRadius: 10,
                            )
                          ],
                          onCompleted: (v) {
                            debugPrint("Completed");
                          },
                          // onTap: () {
                          //   print("Pressed");
                          // },
                          onChanged: (value) {
                            debugPrint("OTP Onchanges "+value);
                            controller.currentOtpText.value = value;
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Obx(() => Text(
                        controller.hasOtpError.value ? "Please enter valid OTP" : "",
                        style: const TextStyle(
                            color: Colors.red,
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),)
                  ),
                  addVerticalSpace(10),
                  Visibility(
                    visible: controller.counter.value != 0,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.watch_later_outlined),
                        SizedBox(width: 10,),
                        Text(
                          controller.counter.value.toString()+" Sec",
                          style: TextStyle(
                              color: Colors.blue.shade200,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],), ),
                  addVerticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),

                      Visibility(
                        visible: controller.counter.value == 0,
                        child: TextButton(
                          onPressed: () {
                            // call API here only
                            otpText.clear();
                            // validateOtp("0","2");
                            controller.counter.value = 60;
                            controller.startTimer();
                            controller.resendOtp(context);

                          },
                          child:  Text(
                            "RESEND",
                            style: TextStyle(
                                color: Colors.blue.shade200,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        replacement: TextButton(
                          onPressed: () {},
                          child:  Text(
                            "RESEND",
                            style: TextStyle(
                                color: Colors.grey.shade300,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),),

                    ],
                  ),
                  addVerticalSpace(20),
                  SizedBox(
                    width: DeviceInfo.deviceWidth()*0.8,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.toNamed(AppRoutes.SIGNUP_PROFILE);

                        if (controller.currentOtpText.value.length == otpLength) {
                          controller.verifyOtp(context);
                        } else {
                          CommanDialog.showToast(context, AppTitles.otp_mobile_valid);
                        }
                      },
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            dark),
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
                          "Continue",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),),
                  addVerticalSpace(20),

                ],
              ),
            )),
          ),
          // Center(
          //   child: Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 30),
          //       child: Scrollbar(
          //       )
          //   ),
          // ),
        ],
      ),
    );
  }
}