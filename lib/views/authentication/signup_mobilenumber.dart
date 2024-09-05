import 'package:country_calling_code_picker/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/authetication/signup_mobile_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/device/deviceInfo.dart';
import '../../utils/supportUI/widget_function.dart';
import '../../widgets/comman_dialog.dart';
class SignUpWithMobileScreen extends GetView<SignUpMobileController> {

  final TextEditingController mobileText = TextEditingController();

  @override
  void dispose(){
    mobileText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: dark
        ),
      ),
      backgroundColor: quinary,
      body: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: Image.asset(
          //       "assets/img/blur_background.png",
          //     ),
          //   ),
          // ),
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
                  addVerticalSpace(DeviceInfo.deviceHeight()*0.15),
                  // Text(
                  //   AppTitles.signup_mobile_title,
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(
                  //       color: dark,fontWeight: FontWeight.w700,fontSize: 25
                  //   ),
                  // ),
                  getPPHattonText(AppTitles.signup_mobile_title, TextAlign.center, dark, FontWeight.w700, 25),
                  addVerticalSpace(20),
                  Text(
                    AppTitles.signup_mobile_subTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: dark,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  addVerticalSpace(50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height :50,
                        color: lightprimary,
                        child: GestureDetector(
                            onTap: () async {
                              final country =
                              await showCountryPickerDialog(
                                context,
                              );
                              if (country != null) {
                                controller.countryCode.value = country.callingCode;
                                controller.countryFlag.value = country.flag;
                                print("controller.countryCode "+controller.countryCode.value.toString());
                                print("controller.flag "+country.flag.toString());
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // addHorizontalSpace(5),
                                  // Image.asset(
                                  //   controller.countryFlag.value,
                                  //   package: "country_calling_code_picker",
                                  //   width: 100,
                                  // ),
                                  // addHorizontalSpace(5),
                                  Text(
                                    controller.countryCode.value,
                                    style: const TextStyle(
                                      color: dark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  addHorizontalSpace(5),
                                  SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: Image.asset(
                                      "assets/image/arrow_down.png",
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                      addHorizontalSpace(15),
                      Container(
                        height: 50,
                        width: DeviceInfo.deviceWidth()*0.62,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: secondary, width: 1),
                        //   borderRadius: BorderRadius.circular(5),
                        // ),
                        color: lightprimary,
                        child: TextField(
                          onChanged: (text) {
                            print('First text field: $text (${text.characters.length})');
                            // controller.authMobileErrorMessage.value = "";
                          },
                          textAlignVertical: TextAlignVertical.center,
                          controller: mobileText,
                          keyboardType: TextInputType.phone,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            // contentPadding: const EdgeInsets.only(
                            //   bottom: 45 / 2,  // HERE THE IMPORTANT PART
                            // ),
                            contentPadding: EdgeInsets.all(10),
                            floatingLabelBehavior:
                            FloatingLabelBehavior.never,
                            labelStyle: const TextStyle(
                                color: dark,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            labelText: AppTitles.signup_mobile_hintText,
                          ),
                          cursorColor: dark,
                          style: const TextStyle(
                              color: dark,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  // Visibility(visible: (controller.authMobileErrorMessage.value.length > 0),child: Container(margin: EdgeInsets.all(10.0),
                  //   child: Text(
                  //     controller.authMobileErrorMessage.value,
                  //     style: TextStyle(
                  //         fontSize: 12,
                  //         fontWeight: FontWeight.w600,
                  //         color: Colors.red
                  //     ),
                  //   ),)),
                  addVerticalSpace(30),
                  Container(
                    width: DeviceInfo.deviceWidth()*0.75,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!mobileText.text.isEmpty && mobileText.text.toString().length >= 10) {
                          controller.mobileNumber.value = mobileText.text.toString();
                          controller.loginWithMobileNumber(context);
                        } else {
                          CommanDialog.showToast(context, AppTitles.signup_mobile_valid);
                        }
                        // controller.loginWithMobileNumber(context);
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
                          'Continue',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: dark
                          ),
                        ),
                      ),
                    ),),
                  addVerticalSpace(10),

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


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xfff7f6fb),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                addUIForMobileNumber(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addUIForMobileNumber() {
    return Container(
      padding: EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          TextFormField(
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (String value) async {
            },
            maxLength: 10,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: txt_mobileNum,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)),
              suffixIcon: SizedBox(
                height: 50,
                width: 70,
                child: Image.asset(
                  'assets/images/mobile_phone.png',
                ),
              ),
            ),
          ),
          addVerticalSpace(15),
          SizedBox(
              width: double.infinity,
              child: Obx(
                    () => Container(
                    child: controller.authState.value == States.LOADING
                        ? ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.purple),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      // child: Padding(
                      //     padding: EdgeInsets.all(5.0),
                      //     child: CircularProgressIndicator(
                      //       color: Colors.white,
                      //     )),
                      child: showLoaderOnButton(quinary),
                    )
                        : ElevatedButton(
                      onPressed: () {
                        if (txt_mobileNum.text.toString().length >= 10) {
                          controller.loginWithNumber(txt_mobileNum.text);
                        } else {
                          controller.authState.value =
                              States.FAILED;
                          controller.authErrorMessage.value = "Enter valid mobile number";
                        }
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
                        padding: EdgeInsets.all(14.0),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
              ))
        ],
      ),
    );
  }
*/
}