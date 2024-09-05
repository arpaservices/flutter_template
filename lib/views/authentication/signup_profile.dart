
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controllers/authetication/signup_profile_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_enums.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/device/deviceInfo.dart';
import '../../utils/supportUI/widget_function.dart';

class SignUpProfileScreen extends GetView<SignUpProfileController> {
  @override
  void dispose() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: quinary,
      body: Column(
        children: [
          addVerticalSpace(40),
          Padding(
            padding:const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset("assets/image/back_button.svg",),
                ),
                addHorizontalSpace(20),
                getPPHattonText("Your Profile", TextAlign.start, dark,FontWeight.bold,18),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Obx(() => SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      addVerticalSpace(50),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.profileSettingPressed(context);
                              },
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          image: (controller.imageIcon.value.isNotEmpty)
                                              ? DecorationImage(
                                                  image: NetworkImage(controller
                                                      .imageIcon.value),
                                                  fit: BoxFit.fill,
                                                )
                                              : DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(controller
                                                      .imageIconDefault
                                                      .value) as ImageProvider,
                                                ),
                                          border: Border.all(
                                            color: veryDarkGrey,
                                            width: 1.5,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: quinary,
                                        ),
                                        child: SizedBox(
                                          width: 14,
                                          height: 14,
                                          child: SvgPicture.asset("assets/image/add_icon.svg"),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      addVerticalSpace(20),
                      Container(
                        height: 50,
                        color: lightprimary,
                        child: TextField(
                          maxLines: 2,
                          onChanged: (text) {
                            print(
                                'firstNameText : $text (${text.characters.length})');
                          },
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.firstNameText,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: const TextStyle(
                                color: dark,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: AppTitles.firstNameHint,
                          ),
                          cursorColor: dark,
                          style: const TextStyle(
                              color: dark,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                      addVerticalSpace(20),
                      Container(
                        height: 50,
                        color: lightprimary,
                        child: TextField(
                          maxLines: 2,
                          onChanged: (text) {
                            print(
                                'lastNameText : $text (${text.characters.length})');
                          },
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.lastNameText,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: const TextStyle(
                                color: dark,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: AppTitles.lastNameHint,
                          ),
                          cursorColor: dark,
                          style: const TextStyle(
                              color: dark,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                      addVerticalSpace(20),
                      Container(
                        height: 50,
                        color: lightprimary,
                        child: TextField(
                          maxLines: 2,
                          onChanged: (text) {
                            print(
                                'emailText : $text (${text.characters.length})');
                          },
                          textAlignVertical: TextAlignVertical.center,
                          controller: controller.emailAddressText,
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            labelStyle: const TextStyle(
                                color: dark,
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            labelText: AppTitles.emailAddressHint,
                          ),
                          cursorColor: dark,
                          style: const TextStyle(
                              color: dark,
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                      addVerticalSpace(
                          controller.isMobileSignIn.value ? 20 : 0),
                      controller.isMobileSignIn.value
                          ? Container(
                              height: 50,
                              color: lightprimary,
                              child: TextField(
                                onChanged: (text) {
                                  print(
                                      'mobileText : $text (${text.characters.length})');
                                },
                                textAlignVertical: TextAlignVertical.center,
                                controller: controller.phoneNumberText,
                                keyboardType: TextInputType.number,
                                enableInteractiveSelection: false,
                                cursorHeight: 0,
                                cursorWidth: 0,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
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
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  labelText: AppTitles.phoneNumberHint,
                                ),
                                cursorColor: dark,
                                style: const TextStyle(
                                    color: dark,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                            )
                          : Container(),
                      addVerticalSpace(20),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.genderSelectedClick(0);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: darkGrey, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: (controller.genderSelected.value ==
                                          GenderEnum.getGender(Gender.male))
                                      ? primary
                                      : quinary),
                              height: 40,
                              width: 80,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: quinary,
                                      border: Border.all(color: dark, width: 1),
                                    ),
                                    child: (controller.genderSelected.value ==
                                            GenderEnum.getGender(Gender.male))
                                        ? Center(
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primary,
                                                border: Border.all(
                                                    color: dark, width: 1),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            // color: quinary,
                                            ),
                                  ),
                                  addHorizontalSpace(5),
                                  Text(
                                    GenderEnum.getGender(Gender.male),
                                    style: const TextStyle(
                                        color: dark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          addHorizontalSpace(10),
                          InkWell(
                            onTap: () {
                              controller.genderSelectedClick(1);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: darkGrey, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: (controller.genderSelected.value ==
                                          GenderEnum.getGender(Gender.female))
                                      ? primary
                                      : quinary),
                              height: 40,
                              width: 100,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: quinary,
                                      border: Border.all(color: dark, width: 1),
                                    ),
                                    child: (controller.genderSelected.value ==
                                            GenderEnum.getGender(Gender.female))
                                        ? Center(
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primary,
                                                border: Border.all(
                                                    color: dark, width: 1),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  addHorizontalSpace(5),
                                  Text(
                                    GenderEnum.getGender(Gender.female),
                                    style: const TextStyle(
                                        color: dark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          addHorizontalSpace(10),
                          InkWell(
                            onTap: () {
                              controller.genderSelectedClick(2);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: darkGrey, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: (controller.genderSelected.value ==
                                          GenderEnum.getGender(Gender.other))
                                      ? primary
                                      : quinary),
                              height: 40,
                              width: 100,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: quinary,
                                      border: Border.all(color: dark, width: 1),
                                    ),
                                    child: (controller.genderSelected.value ==
                                            GenderEnum.getGender(Gender.other))
                                        ? Center(
                                            child: Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primary,
                                                border: Border.all(
                                                    color: dark, width: 1),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  addHorizontalSpace(5),
                                  Text(
                                    GenderEnum.getGender(Gender.other),
                                    style: const TextStyle(
                                        color: dark,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*
                          ElevatedButton(
                            onPressed: () {
                              controller.genderSelectedClick(0);
                            },
                            style: ButtonStyle(
                                backgroundColor: (controller.genderSelectedIndex.value == 0)
                                    ? MaterialStateProperty.all<Color>(
                                    primary)
                                    : MaterialStateProperty.all<Color>(
                                    quinary),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: (controller.genderSelectedIndex.value == 0)
                                          ? const BorderSide(
                                          color: primary, width: 2)
                                          : const BorderSide(color: darkGrey, width: 2),
                                    ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: quinary,
                                    border:
                                    Border.all(color: dark, width: 1),
                                  ),
                                  child: (controller.genderSelectedIndex.value == 0)
                                      ? Center(
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primary,
                                        border: Border.all(
                                            color: dark, width: 1),
                                      ),
                                    ),
                                  )
                                      : Container(
                                    color: quinary,
                                  ),
                                ),
                                addHorizontalSpace(5),
                                Text(
                                  controller.genderList[0],
                                  style: const TextStyle(
                                      color: dark,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          addHorizontalSpace(10),
                          ElevatedButton(
                            onPressed: () {
                              controller.genderSelectedClick(1);
                            },
                            style: ButtonStyle(
                                backgroundColor: (controller.genderSelectedIndex.value == 1)
                                    ? MaterialStateProperty.all<Color>(
                                    primary)
                                    : MaterialStateProperty.all<Color>(
                                    quinary),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: (controller.genderSelectedIndex.value == 1)
                                          ? const BorderSide(
                                          color: primary, width: 2)
                                          : const BorderSide(color: darkGrey, width: 2),
                                    ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: quinary,
                                    border:
                                    Border.all(color: dark, width: 1),
                                  ),
                                  child: (controller.genderSelectedIndex.value == 1)
                                      ? Center(
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primary,
                                        border: Border.all(
                                            color: dark, width: 1),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ),
                                addHorizontalSpace(5),
                                Text(
                                  controller.genderList[1],
                                  style: const TextStyle(
                                      color: dark,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          addHorizontalSpace(10),
                          ElevatedButton(
                            onPressed: () {
                              controller.genderSelectedClick(2);
                            },
                            style: ButtonStyle(
                                backgroundColor: (controller.genderSelectedIndex.value == 2)
                                    ? MaterialStateProperty.all<Color>(
                                    primary)
                                    : MaterialStateProperty.all<Color>(
                                    quinary),
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: (controller.genderSelectedIndex.value == 2)
                                          ? const BorderSide(
                                          color: primary, width: 2)
                                          : const BorderSide(color: darkGrey, width: 2),
                                    ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: quinary,
                                    border:
                                    Border.all(color: dark, width: 1),
                                  ),
                                  child: (controller.genderSelectedIndex.value == 2)
                                      ? Center(
                                    child: Container(
                                      width: 6,
                                      height: 6,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: primary,
                                        border: Border.all(
                                            color: dark, width: 1),
                                      ),
                                    ),
                                  )
                                      : Container(),
                                ),
                                addHorizontalSpace(5),
                                Text(
                                  controller.genderList[2],
                                  style: const TextStyle(
                                      color: dark,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                           */
                        ],
                      ),
                      addVerticalSpace(30),
                      Visibility(
                          visible:
                              (controller.authErrorMessage.value.length > 0),
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            child: Text(
                              controller.authErrorMessage.value,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red),
                            ),
                          )),
                      addVerticalSpace(10),
                      SizedBox(
                        width: DeviceInfo.deviceWidth() * 0.8,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Get.toNamed(AppRoutes.NOTIFICATION_PERMISSION);
                            controller.saveProfileData(context);
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primary),
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
                              "Save",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: dark),
                            ),
                          ),
                        ),
                      ),
                      addVerticalSpace(10),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
