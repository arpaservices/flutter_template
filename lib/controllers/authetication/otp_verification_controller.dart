
import 'dart:async';

import 'package:absaly/data/repositories/user_repository.dart';
import 'package:absaly/route/app_routes.dart';
import 'package:absaly/screens/app_constants.dart';
import 'package:absaly/utils/Services/authentication.dart';
import 'package:country_calling_code_picker/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../data/models/firebase/api_response.dart';
import '../../data/models/firebase/user_model.dart';
import '../../network/DataSource.dart';
import '../../utils/Firebase/firebase_config.dart';
import '../../utils/Services/storage_utils.dart';
import '../../utils/supportUi/comman_dialog.dart';


class OtpVerificationController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  OtpVerificationController({this.dataSourceSuperApp});

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // late Rx<User?> _user;

  RxBool hasOtpError = false.obs;
  RxString authOtpState = "".obs;
  RxString authOtpErrorMessage = "".obs;
  RxString currentOtpText = "".obs;

  RxString countryCode="+91".obs;
  RxString mobileNumber="".obs;

  final AuthServices _authServices = AuthServices();

  @override
  void onInit() {
    startTimer();

    countryCode.value = Get.arguments[AppArg.mobile_country_code];
    mobileNumber.value = Get.arguments[AppArg.mobile_number];

  }


  Timer? _timer;
  RxInt counter = 60.obs;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (Timer timer) {
      if (counter.value == 0) {
        timer.cancel();
      } else {
        counter.value--;
      }
    },
    );
  }

  /*
  void verifyOtp(BuildContext context) async {
      print("verifyOtp "+currentOtpText.toString());
      ApiResponse<Map<String, dynamic>>? response = await _authServices.verifyOTP(currentOtpText.toString());
      if (response != null){
        print("response success "+response!.status.toString());
        print("response success "+response!.message.toString());
        print("response success "+response!.data.toString());
        print("emailAddress "+response!.data!["emailAddress"].toString());
        if (response!.status!.toLowerCase() == "success" && response!.data! != null) {
          LoginUser user = LoginUser.fromJson(response!.data!);
          _authServices.saveToLocalStorage(user);
          CommanDialog.hideLoading();
          StorageUtils.writeboolvalue(Preference.is_MobileSignIn, true);
          bool isPresent = await _authServices.checkAllFieldsArePresent(user);
          print("checkAllFieldsArePresent "+ isPresent.toString());
          if (isPresent){
            Get.toNamed(AppRoutes.HOME,
            );
          }else{
            Get.toNamed(AppRoutes.PROFILE,
              arguments: {
                AppArg.login_user:user,
              },
            );
          }
        }else{
          CommanDialog.showToast(context, "Error in validating OTP");
        }
      }else {
        CommanDialog.showToast(context, "Kindly enter valid OTP");
      }
  }
  */

  void verifyOtp(BuildContext context) async {
    CommanDialog.showLoading();
      print("verifyOtp "+currentOtpText.toString());
      ApiResponse<LoginUser>? response = await _authServices.verifyOTP(currentOtpText.toString());
      if (response != null){
        print("response success "+response.status.toString());
        print("response success "+response.message.toString());
        print("response success "+response.data.toString());
        if (response.status.toLowerCase() == "success") {
          await _authServices.saveToLocalStorage(response.data!);
          CommanDialog.hideLoading();
          StorageUtils.writeboolvalue(Preference.is_MobileSignIn, true);
          bool isPresent = await _authServices.checkAllFieldsArePresent(response.data!);
          print("checkAllFieldsArePresent in OTP Verification"+ isPresent.toString());
          if (isPresent){
            Get.toNamed(AppRoutes.HOME,
            );
          }else{
            Get.toNamed(AppRoutes.PROFILE,
              arguments: {
                AppArg.login_user:response.data!,
              },
            );
          }
        }else{
          CommanDialog.hideLoading();
          CommanDialog.showToast(context, "Error in Sign In");
        }
      }else {
        CommanDialog.hideLoading();
        CommanDialog.showToast(context, "Something Went Wrong");
      }
  }

  resendOtp(BuildContext context) async {
    await _authServices.phoneVerification(
        countryCode+mobileNumber.trim(), () {}, () {
      CommanDialog.showToast(context, "Error sending otp");
    });
  }


}