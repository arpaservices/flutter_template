import 'dart:async';


import 'package:get/get.dart';


class SplashController extends GetxController {


  @override
  void onInit() async {
    super.onInit();


  }

  void splashScreenLogic() async {
    // FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    // firebaseMessaging.requestPermission();
    // String? token = await firebaseMessaging.getToken();
    // print("fcm token" + token!);
    // isUserDataAvailable().then((userDataExists) async {
    //   if (userDataExists) {
    //     Constants.USER_DATA = await getProfileDataLocally();
    //     print(Constants.USER_DATA?.userIcon);
    //     startTimerForSplash(AppRoutes.MAINPAGE);
    //   } else {
    //     startTimerForSplash(AppRoutes.ONBOARDING);
    //   }
    // });
  }

  void startTimerForSplash(String navigateTo) {
    int delay = 1;
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (delay == 0) {
          timer.cancel();
          print('navigated');
          Get.offNamed(navigateTo);
        } else {
          delay--;
        }
      },
    );
  }

}
