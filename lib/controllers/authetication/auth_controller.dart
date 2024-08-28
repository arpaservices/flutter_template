

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../routes/app_routes.dart';
import '../../utils/network/DataSource.dart';



class AuthController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  AuthController({this.dataSourceSuperApp});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;

  RxString authState = "".obs; // loading,no_internet,success,failed,
  RxString authErrorMessage = "".obs;

  @override
  void onInit() {

    super.onInit();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.authStateChanges());
    // _handleAuthState();
  }

  void _handleAuthState() {
    // Check if the user is already signed in
    if (_user.value != null) {
      Get.offAllNamed(AppRoutes.HOME);
    }
  }


  _initialScreen(User? user) {
    if (user == null) {
      if (kDebugMode) {
        print('No user found');
      }
      Get.offAllNamed(AppRoutes.SIGNINPHONE);
    } else {
      if (kDebugMode) {
        print('User Already Present');
      }
      Get.offAllNamed(AppRoutes.HOME);
    }
  }
  void createUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  /*
  void loginWithNumber(String phoneNumber) async {
    print("loginWithNumber "+phoneNumber);
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            // await _auth.signInWithCredential(credential);
            CommanDialog.hideLoading();
            Get.offAllNamed(AppRoutes.HOME);
          },
          verificationFailed: (FirebaseAuthException e) {
            print("Verification Failed:" +e.toString());
            Get.snackbar('Verification Failed:' ,e.toString());
            CommanDialog.hideLoading();
      },
        codeSent: (String verificationId, int? resendToken) async {
          Get.snackbar('Code Sent' ,"Successfully");
          CommanDialog.hideLoading();
          // Get.toNamed(AppRoutes.VERIFYPHONE, arguments: {
          //   'verificationId': verificationId,
          // });
          Get.toNamed(
            AppRoutes.VERIFYPHONE,
            arguments: {
              AppArg.verification_Id:verificationId,
              AppArg.mobile_number:phoneNumber,
              AppArg.mobile_country_code:countryCode,
            },
          );
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
  */
  void verifyCode(String _verificationId,String smsCode) async {

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      Get.toNamed(AppRoutes.HOME);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }


  Future<void> signOutFromGoogle() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }



  Future<bool> signOut() async {
    try{
      await _auth.signOut();
      await signOutFromGoogle();
      Get.offAllNamed(AppRoutes.SIGNINPHONE);
      return true;
    } catch (e) {
      log('Error signing out: $e');
      return false;
    }
    return false;
  }
}