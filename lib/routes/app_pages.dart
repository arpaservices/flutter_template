


import 'package:flutter_template/controllers/splash_controller.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../bindings/authentication/auth_binding.dart';
import '../bindings/authentication/mobile_otp_bindings.dart';
import '../bindings/authentication/signup_mobile_bindings.dart';
import '../bindings/authentication/signup_profile_bindings.dart';
import '../bindings/authentication/signup_social_login_bindings.dart';
import '../bindings/generic_binding.dart';
import '../bindings/settings/setting_binding.dart';
import '../controllers/home_controller.dart';
import '../controllers/subscription/app_subscription_controller.dart';
import '../controllers/subscription/subscription_controller.dart';
import '../views/authentication/notification_permission.dart';
import '../views/authentication/signin.dart';
import '../views/authentication/signup.dart';
import '../views/authentication/signup_mobilenumber.dart';
import '../views/authentication/signup_profile.dart';
import '../views/authentication/signup_social_login.dart';
import '../views/authentication/verify_otp_screen.dart';
import '../views/home/home_screen.dart';
import '../views/settings/setting_screen.dart';
import '../views/splash/splash_screen.dart';
import '../views/subscription/app_subscription_screen.dart';
import '../views/subscription/subscription_screen.dart';
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
      binding: GenericBinding(SubscriptionController()),
    ),
    GetPage(
      name: AppRoutes.APPSUBSCRIPTION,
      page: () => AppSubscriptionScreen(),
      binding: GenericBinding(AppSubscriptionController()),
    ),
  ];
}