
import 'dart:async';

import 'package:country_calling_code_picker/country.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../models/firebase/user_model.dart';
import '../../models/generic/api_response.dart';
import '../../routes/app_routes.dart';
import '../../services/Firebase/firebase _authentication.dart';
import '../../services/localStorage/storage_utils.dart';
import '../../utils/core/app_strings.dart';
import '../../utils/network/DataSource.dart';
import '../../utils/supportUI/comman_dialog.dart';



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
      print("verifyOtp $currentOtpText");
      ApiResponse<LoginUser>? response = await _authServices.verifyOTP(currentOtpText.toString());
      print("response success ${response?.status}");
      print("response success ${response?.message}");
      print("response success ${response?.data}");
      if (response?.status.toLowerCase() == "success") {
        await _authServices.saveToLocalStorage(response?.data??LoginUser(id: "id", firstName: "", lastName: "", profileImage: "", phoneNumber: "", emailAddress: "", gender: "", isDeleted: false));
        CommanDialog.hideLoading();
        StorageUtils.writeboolvalue(Preference.is_MobileSignIn, true);
        bool isPresent = await _authServices.checkAllFieldsArePresent(response?.data??LoginUser(id: "id", firstName: "", lastName: "", profileImage: "", phoneNumber: "", emailAddress: "", gender: "", isDeleted: false));
        print("checkAllFieldsArePresent in OTP Verification$isPresent");
        if (isPresent){
          Get.toNamed(AppRoutes.HOME,
          );
        }else{
          Get.toNamed(AppRoutes.PROFILE,
            arguments: {
              AppArg.login_user:response?.data,
            },
          );
        }
      }else{
        CommanDialog.hideLoading();
        CommanDialog.showToast(context, "Error in Sign In");
      }
      }

  resendOtp(BuildContext context) async {
    await _authServices.phoneVerification(
        countryCode+mobileNumber.trim(), () {}, () {
      CommanDialog.showToast(context, "Error sending otp");
    });
  }


}