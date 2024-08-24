


import 'package:flutter_template/controllers/splash_controller.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bindings/generic_binding.dart';
import '../controllers/home_controller.dart';
import '../views/home/home_screen.dart';
import '../views/splash/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static var list = [
    // GetPage(
    //   name: AppRoutes.WELCOME,
    //   page: () => SplashScreen(),
    //   binding: SplashBinding(),
    // ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
      binding: GenericBinding(SplashController()),
    ),
    GetPage(
      name: AppRoutes.SIGNINPHONE,
      page: () => SignUpWithMobileScreen(),
      binding: SignUpMobileBinding(),
    ),
    GetPage(
      name: AppRoutes.VERIFYPHONE,
      page: () => VerificationScreen(),
      binding: MobileOtpBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP_PROFILE,
      page: () => SignUpProfileScreen(),
      binding: SignUpProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.NOTIFICATION_PERMISSION,
      page: () => NotificationPermissionScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP_SOCIALLOGIN,
      page: () => SignUpSocialLoginScreen(),
      binding: SignUpSocialLoginBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNIN,
      page: () => SignInScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGNUP,
      page: () => SignUpScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: GenericBinding(HomeController()),
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => SignUpProfileScreen(),
      binding: SignUpProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTING,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.SUBSCRIPTION,
      page: () => SubscriptionScreen(),
      binding: SubscriptionBinding(),
    ),
    GetPage(
      name: AppRoutes.APPSUBSCRIPTION,
      page: () => AppSubscriptionScreen(),
      binding: AppSubscriptionBinding(),
    ),
  ];
}