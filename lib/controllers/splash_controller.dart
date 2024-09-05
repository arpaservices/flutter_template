import 'package:get/get.dart';

import '../routes/app_routes.dart';
import '../services/Firebase/firebase _authentication.dart';
import '../utils/network/DataSource.dart';
import 'connection/connection_manager_controller.dart';

class SplashController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  SplashController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  final AuthServices _authServices = AuthServices();

  // Timer _timer = Timer();

  @override
  void onInit() {
    super.onInit();
    print("onInit SplashController");
  }

  void startTimerForSplash() async {
    bool isDataAvailable = await _authServices.isUserDataAvailable();
    print("isdataAvailable= $isDataAvailable");
    Future.delayed(
        const Duration(seconds: 2),
            () => Get.toNamed(isDataAvailable ? AppRoutes.HOME : AppRoutes.SIGNUP_SOCIALLOGIN));

    // Future.delayed(
    //     const Duration(seconds: 3),
    //         () => Get.toNamed(AppRoutes.SUBSCRIPTION));
  }
}