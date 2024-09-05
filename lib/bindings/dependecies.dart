
import 'package:get/get.dart';

import '../controllers/authetication/auth_controller.dart';
import '../controllers/authetication/otp_verification_controller.dart';
import '../controllers/authetication/signup_controller.dart';
import '../controllers/authetication/signup_mobile_controller.dart';
import '../controllers/authetication/signup_profile_controller.dart';
import '../controllers/authetication/signup_social_login_controller.dart';
import '../controllers/connection/connection_manager_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/settings/setting_controller.dart';
import '../controllers/splash_controller.dart';
import '../controllers/subscription/app_subscription_controller.dart';
import '../controllers/subscription/subscription_controller.dart';
import '../utils/network/DataSource.dart';

void bindingConnectionManagerController() =>
    Get.lazyPut<ConnectionManagerController>(
            () => ConnectionManagerController());

void bindingSplashController() => Get.lazyPut<SplashController>(
        () => SplashController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingSignUpController() => Get.lazyPut<SignUpController>(
        () => SignUpController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingSignUpSocialLoginController() => Get.lazyPut<SignUpSocialLoginController>(
        () => SignUpSocialLoginController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingAuthController() => Get.lazyPut<AuthController>(
        () => AuthController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingMobileOtpController() => Get.lazyPut<OtpVerificationController>(
        () => OtpVerificationController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingSignUpMobileController() => Get.lazyPut<SignUpMobileController>(
        () => SignUpMobileController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingSignUpProfileController() => Get.lazyPut<SignUpProfileController>(
        () => SignUpProfileController(dataSourceSuperApp: Get.find<DataSourceClass>()));


void bindingHomeController() => Get.lazyPut<HomeController>(
        () => HomeController(dataSourceSuperApp: Get.find<DataSourceClass>()));


/* For Setting Section */

void bindingSettingController() => Get.lazyPut<SettingController>(
        () => SettingController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingSubscriptionController() => Get.lazyPut<SubscriptionController>(
        () => SubscriptionController(dataSourceSuperApp: Get.find<DataSourceClass>()));

void bindingAppSubscriptionController() => Get.lazyPut<AppSubscriptionController>(
        () => AppSubscriptionController(dataSourceSuperApp: Get.find<DataSourceClass>()));