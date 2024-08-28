
import 'dart:developer';

import 'package:absaly/network/DataSource.dart';
import 'package:absaly/route/app_routes.dart';
import 'package:absaly/utils/Services/firebase _authentication.dart';
import 'package:absaly/utils/Services/storage_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/firebase/api_response.dart';
import '../../data/models/firebase/user_model.dart';
import '../../screens/app_constants.dart';
import '../../utils/supportUi/comman_dialog.dart';
import '../connection_manager_controller.dart';


class SignUpSocialLoginController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  SignUpSocialLoginController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  final AuthServices _authServices = AuthServices();

  @override
  void onInit() {
    super.onInit();
  }

  launchWebsite(String url)async{
    var uri =
    Uri.parse(url);
    await launchUrl(uri);
  }
  /*
  signUpWithGmailPressed(BuildContext context)async{
    ApiResponse<Map<String, dynamic>>? response = await _authServices.signInWithGoogle();
    CommanDialog.showLoading(title: "Loading");
    log("result signUpWithGmailPressed "+response.toString());
    if (response != null){
      log("response success "+response.status.toString());
      log("response success "+response.message.toString());
      log("response success "+response.data.toString());
      log("emailAddress "+response.data!["emailAddress"].toString());
      if (response.status.toLowerCase() == "success") {
        LoginUser user = LoginUser.fromJson(response.data!);
        _authServices.saveToLocalStorage(user);
        CommanDialog.hideLoading();
        StorageUtils.writeboolvalue(Preference.is_GoogleSignIn, true);
        bool isPresent = await checkAllFieldsArePresent(user);
        log("checkAllFieldsArePresent "+ isPresent.toString());
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
        /*
          if(user!.emailAddress == null) {
            Get.toNamed(AppRoutes.PROFILE,
              arguments: {
              AppArg.login_user:user,
              },
            );
          }else{
            FirebaseConfig config = FirebaseConfig();
            bool isSetUp = await config.checkUpNotification();
            if (!isSetUp) {
              Get.toNamed(AppRoutes.NOTIFICATION_PERMISSION);
            } else{
              Get.toNamed(AppRoutes.HOME);
            }
          }
           */
      }else{
        CommanDialog.hideLoading();
        CommanDialog.showToast(context, "Error in Google Sign In");
      }
    }else {
      CommanDialog.hideLoading();
      CommanDialog.showToast(context, "Something Went Wrong");
    }

  }

  signUpWithApplePressed(BuildContext context) async{
    ApiResponse<Map<String, dynamic>>? response = await _authServices.signInWithAppleiOS();
    log("result signUpWithApple "+response.toString());
    if (response != null){
      log("response success "+response.status.toString());
      log("response success "+response.message.toString());
      log("response success "+response.data.toString());
      log("emailAddress "+response.data!["emailAddress"].toString());
      if (response.status.toLowerCase() == "success") {
        LoginUser user = LoginUser.fromJson(response.data!);
        _authServices.saveToLocalStorage(user);
        CommanDialog.hideLoading();
        StorageUtils.writeboolvalue(Preference.is_GoogleSignIn, true);
        bool isPresent = await checkAllFieldsArePresent(user);
        log("checkAllFieldsArePresent "+ isPresent.toString());
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
        /*
          if(user!.emailAddress == null) {
            Get.toNamed(AppRoutes.PROFILE,
              arguments: {
              AppArg.login_user:user,
              },
            );
          }else{
            FirebaseConfig config = FirebaseConfig();
            bool isSetUp = await config.checkUpNotification();
            if (!isSetUp) {
              Get.toNamed(AppRoutes.NOTIFICATION_PERMISSION);
            } else{
              Get.toNamed(AppRoutes.HOME);
            }
          }
           */
      }else{
        CommanDialog.hideLoading();
        CommanDialog.showToast(context, "Error in Apple Sign In");
      }
    }else {
      CommanDialog.hideLoading();
      CommanDialog.showToast(context, "Something Went Wrong");
    }
  }
  */

/*
  signUpWithGmailPressed(BuildContext context)async{
    ApiResponse<Map<String, dynamic>>? response = await _authServices.signInWithGoogle();
    CommanDialog.showLoading(title: "Loading");
    log("result signUpWithGmailPressed "+response.toString());
    if (response != null){
      log("response success "+response.status.toString());
      log("response success "+response.message.toString());
      log("response success "+response.data.toString());
      log("emailAddress "+response.data!["emailAddress"].toString());
      if (response.status.toLowerCase() == "success") {
        LoginUser user = LoginUser.fromJson(response.data!);
        _authServices.saveToLocalStorage(user);
        CommanDialog.hideLoading();
        StorageUtils.writeboolvalue(Preference.is_GoogleSignIn, true);
        bool isPresent = await _authServices.checkAllFieldsArePresent(user);
        log("checkAllFieldsArePresent "+ isPresent.toString());
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
        CommanDialog.hideLoading();
        CommanDialog.showToast(context, "Error in Google Sign In");
      }
    }else {
      CommanDialog.hideLoading();
      CommanDialog.showToast(context, "Something Went Wrong");
    }

  }

  signUpWithApplePressed(BuildContext context) async{
    ApiResponse<LoginUser>? response = await _authServices.signInWithAppleiOS();
    log("result signUpWithApple "+response.toString());
    if (response != null){
      log("response success "+response.status.toString());
      log("response success "+response.message.toString());
      log("response success "+response.data.toString());
      if (response.status.toLowerCase() == "success") {
        _authServices.saveToLocalStorage(response.data!);
        CommanDialog.hideLoading();
        StorageUtils.writeboolvalue(Preference.is_GoogleSignIn, true);
        bool isPresent = await _authServices.checkAllFieldsArePresent(response.data!);
        log("checkAllFieldsArePresent "+ isPresent.toString());
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
        CommanDialog.showToast(context, "Error in Apple Sign In");
      }
    }else {
      CommanDialog.hideLoading();
      CommanDialog.showToast(context, "Something Went Wrong");
    }
  }
*/

  signUpWithGmailAndApplePressed(String signUpType,BuildContext context) async{
    ApiResponse<LoginUser>? response = (signUpType.toLowerCase() == Preference.is_GoogleSignIn.toLowerCase()) ? await _authServices.signInWithGoogle() : await _authServices.signInWithAppleiOS();
    log("result  " + signUpType + " " +response.toString());
    if (response != null){
      log("response success "+response.status.toString());
      log("response success "+response.message.toString());
      log("response success "+response.data.toString());
      if (response.status.toLowerCase() == "success") {
        await _authServices.saveToLocalStorage(response.data!);
        CommanDialog.hideLoading();
        log("signUpType "+signUpType);
        StorageUtils.writeboolvalue(signUpType, true);
        bool isPresent = await _authServices.checkAllFieldsArePresent(response.data!);
        log("checkAllFieldsArePresent in Social Login"+ isPresent.toString());
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


  signUpWithMobile(){
    Get.toNamed(AppRoutes.SIGNINPHONE);
  }

}
