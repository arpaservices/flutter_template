


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/app_routes.dart';
import '../../services/Firebase/firebase _authentication.dart';
import '../../services/Firebase/firebase_config.dart';
import '../../services/localStorage/storage_utils.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/network/DataSource.dart';
import '../../widgets/comman_dialog.dart';
import '../connection/connection_manager_controller.dart';

class SettingController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  SettingController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  RxString userName = "".obs;
  RxString userEmail = "".obs;
  RxString imageIcon = "".obs;
  // RxString imageIconDefault = "assets/image/user_profile.png".obs;
  RxString imageIconDefault = "assets/image/men_image.png".obs;

  final AuthServices _authServices = AuthServices();

  @override
  void onInit() {

    userName.value = StorageUtils.readvaluefromgetstorage(Preference.user_Name);
    userEmail.value = StorageUtils.readvaluefromgetstorage(Preference.user_EmailAddress);
    imageIcon.value = StorageUtils.readvaluefromgetstorage(Preference.user_ProfileImage);

    super.onInit();

  }

  onProfileSettingPressed(){

  }
  onNotificationPressed(BuildContext context) async {

    FirebaseConfig config = FirebaseConfig();
    bool isSetUp = await config.checkUpNotification();
    if (!isSetUp) {
      Get.toNamed(AppRoutes.NOTIFICATION_PERMISSION);
    } else{
      CommanDialog.showToast(context, "Notification Permission is already given");
    }

  }
  onSubscriptionPressed(){
    // Get.toNamed(AppRoutes.SUBSCRIPTION);
    Get.toNamed(AppRoutes.APPSUBSCRIPTION);
  }

  onPrivacyPressed(){

  }
  onHelpPressed(){

  }
  onInviteFriendsPressed(){

  }
  onMadeWithPressed(){

  }
  onLogoutPressed() async {
  // Remove all values from GetX

    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    _authServices.removeFromLocalStorage();
    Get.toNamed(AppRoutes.SIGNUP_SOCIALLOGIN);
  }

  launchWebsite(String url)async{
    var uri =
    Uri.parse(url);
    await launchUrl(uri);
  }

}
