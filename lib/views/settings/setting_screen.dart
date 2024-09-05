
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../controllers/settings/setting_controller.dart';
import '../../utils/core/app_colors.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/supportUi/widget_function.dart';

class SettingScreen extends GetView<SettingController> {



  @override
  void dispose(){
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary_bg,
        leading: BackButton(
            color: dark
        ),
        // title: Text(
        //   "Settings",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //       color: dark,
        //       fontWeight: FontWeight.w700,
        //       fontSize: 25),
        // ),
        title: getPPHattonText("Settings", TextAlign.center, dark, FontWeight.w600, 22),
      ),
      body: Stack(
        children: [
          setProfile(context),
        ],
      ),
    );
  }


  Widget setProfile(BuildContext context){
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //     padding: const EdgeInsets.only(top: 50,left: 20,right: 20),
            //     child: Container(
            //       decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(10),
            //           color: quinary,
            //           border: Border.all(color: darkGrey, width: 0.5),
            //           boxShadow: [
            //             BoxShadow(
            //               color: darkGrey.withOpacity(0.5),
            //               spreadRadius: 5,
            //               blurRadius: 7,
            //               offset: const Offset(0, 1),
            //             )
            //           ]
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            //         child: Container()
            //       ),
            //
            //     ),
            //   ),
            // ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                addHorizontalSpace(20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: BoxDecoration(
                      image: (controller.imageIcon.value.isNotEmpty) ? DecorationImage(
                        image: NetworkImage(controller.imageIcon.value),
                        fit: BoxFit.fill,
                      ) : DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(controller.imageIconDefault.value) as ImageProvider,
                      ),
                      border: Border.all(
                        color: veryDarkGrey,
                        width: 1.5,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                addHorizontalSpace(20),
                Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.userName.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: dark,
                      ),
                    ),
                    Text(controller.userEmail.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: textDarkGrey,
                      ),
                    ),
                  ],
                ),
                addHorizontalSpace(20),
              ],
            ),),
            addVerticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  addVerticalSpace(15),
                  clickableControl((){controller.onProfileSettingPressed();}, AppTitles.ProfileSettings, "assets/image/icon.png"),
                  // Container(width: double.infinity,height: 0.5,color: settingSeperator,),
                  // clickableControl((){controller.onNotificationPressed(context);}, AppTitles.Notification, "assets/image/setting_notification.png"),
                  Container(width: double.infinity,height: 0.5,color: settingSeperator,),
                  clickableControl((){controller.onSubscriptionPressed();}, AppTitles.Subscription, "assets/image/setting_privacy.png"),
                  // Container(width: double.infinity,height: 0.5,color: settingSeperator,),
                  // clickableControl((){controller.onHelpPressed();}, AppTitles.Help, "assets/image/setting_help.png"),
                  Container(width: double.infinity,height: 0.5,color: settingSeperator,),
                  clickableControl(()async{await controller.launchWebsite(AppUrls.privacyPolicyUrl);}, AppTitles.privacyPolicy, "assets/image/setting_privacy.png"),
                  // Container(width: double.infinity,height: 0.5,color: settingSeperator,),
                  // clickableControl((){controller.onInviteFriendsPressed();}, AppTitles.InviteYourFriends, "assets/image/setting_invite.png"),
                  Container(width: double.infinity,height: 0.5,color: settingSeperator,),
                  clickableControl((){controller.onMadeWithPressed();}, AppTitles.MadewithlovebyARPA, "assets/image/love_by_arpa.png",),
                  Container(width: double.infinity,height: 0.5,color: settingSeperator,),
                  deleteButton((){controller.onLogoutPressed();}, AppTitles.Logout, "assets/image/setting_logout.png",),
                  // addVerticalSpace(15),
                  // clickableControl(()async{await launchWebsite(websiteUrl);}, webTxt, "assets/image/link.png"),
                  // Container(width: double.infinity,height: 0.5,color: darkGrey,),
                  // clickableControl(()async{await launchWebsite(privacyPolicyUrl);}, privacyPolicyTxt, "assets/image/file_text.png"),
                  // Container(width: double.infinity,height: 0.5,color: darkGrey,),
                  // clickableControl(()async{await launchWebsite(termsAndCondition);}, termsAndCondition, "assets/image/book.png"),
                  // addVerticalSpace(20),
                ],
              ),
            ),
            addVerticalSpace(10),

          ],
        ),
      ),
    );
  }

  Widget clickableControl(dynamic onClick, String title, String imageLink){
    return InkWell(
      onTap:onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 28, height: 28,
                  child: Image.asset(imageLink),
                ),
                addHorizontalSpace(10),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: dark,
                  ),
                ),
              ],
            ),
            SizedBox(
                width: 20,height: 20,
                child: Image.asset("assets/image/caret_right.png"))
          ],
        ),
      ),
    );
  }

  Widget deleteButton(dynamic onClick, String title, String imageLink){
    return InkWell(
      onTap:onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 28, height: 28,
                  child: Image.asset(imageLink),
                ),
                addHorizontalSpace(10),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }

}