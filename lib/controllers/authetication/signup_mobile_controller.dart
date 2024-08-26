
import 'package:absaly/data/repositories/user_repository.dart';
import 'package:absaly/network/DataSource.dart';
import 'package:absaly/route/app_routes.dart';
import 'package:absaly/screens/app_constants.dart';
import 'package:absaly/utils/Services/authentication.dart';
import 'package:absaly/utils/Services/storage_utils.dart';
import 'package:absaly/utils/supportUi/comman_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../connection_manager_controller.dart';


class SignUpMobileController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  SignUpMobileController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  final AuthServices _authServices = AuthServices();

  /*For Mobile Number*/
  // RxString authMobileState = "".obs;
  // RxString authMobileErrorMessage = "".obs;

  RxString countryCode="+91".obs;
  RxString mobileNumber="".obs;
  RxString countryFlag="".obs;

  @override
  void onInit() {
    super.onInit();
  }

  loginWithMobileNumber(BuildContext context){
    // CommanDialog.showLoading();
    StorageUtils.writevalueinstorage(Preference.user_CountryCode, countryCode.value);
    StorageUtils.writevalueinstorage(Preference.user_Mobile, mobileNumber.trim());
    StorageUtils.writevalueinstorage(Preference.user_PhoneNumber, countryCode+mobileNumber.trim());
    _authServices.phoneVerification(countryCode+mobileNumber.trim(),onSuccess,onFailed(context));


    // print("loginWithMobileNumber");
    // LoginUser user = LoginUser(id: "Jc8CKtQEQDe3kdmrjdoWs4pU0Vo2", name: "", profileImage: "", phoneNumber: "+919321694960", emailAddress: "", isDeleted: false);
    // Get.toNamed(AppRoutes.PROFILE,
    //   arguments: {
    //     AppArg.login_user:user,
    //   },
    // );
  }

  onSuccess(){
    Get.toNamed(
      AppRoutes.VERIFYPHONE,
      arguments: {
        AppArg.mobile_number:mobileNumber.toString(),
        AppArg.mobile_country_code:countryCode.toString(),
      },
    );
  }
  onFailed(BuildContext context){
    // CommanDialog.showToast(context, "Error sending OTP");
  }

}