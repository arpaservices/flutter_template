import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_template/data/repositories/user_repository.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../models/firebase/user_model.dart';
import '../../models/generic/api_response.dart';
import '../../utils/core/app_strings.dart';
import '../../widgets/comman_dialog.dart';
import '../localStorage/storage_utils.dart';
import 'Firestore/auditFields.dart';

class AuthServices {
  var userId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final DatabaseReference DBRef = FirebaseDatabase.instance.ref(FirebaseCollection.users);
  // final CollectionReference userDB = FirebaseFirestore.instance.collection(FirebaseCollection.users);
  // final CollectionReference userDB = FirebaseFirestore.instance.collection(FirebaseCollection.users);
  var verificationId = ''.obs;

  var credential;

  // UsersInfo? _userFromFirebaseUser(User? user){
  //   return user!=null ? UsersInfo(uid : user.uid) : null;
  // }
  String errorMessage = "Error !!!";
  UserRepository _repository = UserRepository();

  getCurrentUser() async {
    final User user = _auth.currentUser!;
  }

  Future phoneVerification(
      String phoneNumber, dynamic onSuccess, dynamic verificationFailed) async {
    CommanDialog.showLoading();
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {

      },
      verificationFailed: (FirebaseAuthException e) {
        CommanDialog.hideLoading();
        verificationFailed();
      },
      codeSent: (String verificationId, int? resendToken) {
        // verify = verificationId.toString();
        log("verificationId $verificationId");
        StorageUtils.writevalueinstorage(Preference.verificationId, verificationId.toString());
        this.verificationId.value = verificationId;
        CommanDialog.hideLoading();
        onSuccess();
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }


  // verifyOTP
  Future<ApiResponse<LoginUser>?> verifyOTP(String otp) async {
    try {
      String verify = StorageUtils.readvaluefromgetstorage(Preference.verificationId);
      log("verify $verify");
      PhoneAuthCredential c =
      PhoneAuthProvider.credential(verificationId: verify, smsCode: otp);
      log("message");
      UserCredential credential = await _auth.signInWithCredential(c);
      log("credential $credential");
      User user = credential.user!;
      log("result.user $user");

      String firstName = (user.displayName??"").split(' ').first;
      String lastName = (user.displayName??"").split(' ').last;
      LoginUser newUser = LoginUser(
        id: user.uid,
        firstName: firstName,
        lastName:lastName,
        profileImage: user.photoURL,
        phoneNumber: user.phoneNumber,
        emailAddress: user.email,
        gender: "",
        isDeleted: false,
      );

      bool isDocumentPresent =await isDocumentExist(FirebaseCollection.users,user.uid);
      if(isDocumentPresent == true){
        log("USER ID IS ALREADY CRESATED");
        // LoginUser? userData = await _repository.getUser(user.uid);
        // if (userData != null){
        //   return await _repository.createNewUser(userData);
        // }
        return ApiResponse(status: "success", message: "success",data: await _repository.getUser(user.uid));
      }

      return await _repository.createNewUser(newUser);

    } on FirebaseAuthException catch (e) {
      // TODO
      Logger logger = Logger();
      logger.e("Error in Sending OTP $e");
      CommanDialog.hideLoading();
    }
    return null;
  }

  //Sign in using Google
  Future<ApiResponse<LoginUser>?> signInWithGoogle() async {
    try {

      final googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential result = await _auth.signInWithCredential(credential);
      User user = result.user!;
      log("result.user $user");
      log("result.user uid${user.uid}");
      // String dateCreated = DateFormat("yyyy-MM-dd").format(DateTime.now());
      // bool status = false;
      String firstName = (user.displayName??"").split(' ').first;
      String lastName = (user.displayName??"").split(' ').last;

      LoginUser newUser = LoginUser(
        id: user.uid,
        firstName: firstName,
        lastName:  lastName,
        profileImage: user.photoURL,
        phoneNumber: user.phoneNumber,
        emailAddress: user.email,
        gender: "",
        isDeleted: false,
      );
      bool isDocumentPresent =await isDocumentExist(FirebaseCollection.users,user.uid);
      if(isDocumentPresent == true){
        log("USER ID IS ALREADY CRESATED");
        // LoginUser? userData = await _repository.getUser(user.uid);
        // if (userData != null){
        //   return await _repository.createNewUser(userData);
        // }
        return ApiResponse(status: "success", message: "success",data: await _repository.getUser(user.uid));
      }
      return await _repository.createNewUser(newUser);

    } on Exception catch (e) {
      var logger = Logger();
      logger.e("error occurred : ${e.toString()}");
      return null; // TODO
    }
  }

  //Sign in using Apple
  Future<ApiResponse<LoginUser>?> signInWithAppleiOS() async {
    try {
      CommanDialog.showLoading(title: "Loading");
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      log("appleCredential value $appleCredential");
      log("DISPLAY givenName value ${appleCredential.givenName}");
      log("DISPLAY familyName value ${appleCredential.familyName}");
      log("DISPLAY authorizationCode value ${appleCredential.authorizationCode}");
      log("DISPLAY email value ${appleCredential.state}");
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
      );
      log("oauthCredential value $oauthCredential");

      final appleUser = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      log("appleCredential value $appleUser");
      if (appleUser.user != null) {
        String dateCreated = DateFormat("yyyy-MM-dd").format(DateTime.now());
        bool status = false;
        log("UID DISPLAY EMAIL");
        String appleUID = (appleUser.user!.uid != null) ? appleUser.user!.uid
            .toString() : "";
        log("Apple UID $appleUID");
        // String displayName = (appleUser.user!.displayName != null) ? appleUser.user!.displayName.toString() : "";
        String displayName = (appleCredential.givenName != null)
            ? appleCredential.givenName.toString()
            : "";
        log("Apple displayName $displayName");
        String familyName = (appleCredential.familyName != null)
            ? appleCredential.familyName.toString()
            : "";
        log("Apple familyName $familyName");
        String email = (appleUser.user!.email != null) ? appleUser.user!.email
            .toString() : "";
        log("Apple email $email");
        String photoURL = (appleUser.user!.photoURL != null) ? appleUser.user!
            .photoURL.toString() : "";
        log("Apple photoURL $photoURL");

        LoginUser newUser = LoginUser(
          id: appleUID,
          firstName: displayName,lastName:familyName ,
          profileImage: photoURL,
          phoneNumber: "",
          emailAddress: email,
          gender: "",
          isDeleted: false,
        );
        CommanDialog.hideLoading();
        bool isDocumentPresent =await isDocumentExist(FirebaseCollection.users,appleUID);
        if(isDocumentPresent == true){
          log("USER ID IS ALREADY CRESATED");
          // LoginUser? userData = await _repository.getUser(appleUID);
          // if (userData != null){
          //   return await _repository.createNewUser(userData);
          // }
          return ApiResponse(status: "success", message: "success",data: await _repository.getUser(appleUID));
        }
        return await _repository.createNewUser(newUser);
      }
      return null;

    } on Exception catch (e) {
      CommanDialog.hideLoading();
      var logger = Logger();
      logger.e("error occurred : ${e.toString()}");
      return null; // TODO
    }
  }


  Future<bool> checkAllFieldsArePresent(LoginUser user) async {
    bool isNamePresent = ((user.firstName != null) && user.firstName!.length > 0);
    bool isEmailPresent = ((user.emailAddress != null) && user.emailAddress!.length > 0);
    bool isGenderPresent = ((user.gender != null) && user.gender!.length > 0);
    print("isNamePresent $isNamePresent");
    print("isEmailPresent $isEmailPresent");
    print("isGenderPresent $isGenderPresent");
    return (isNamePresent && isEmailPresent && isGenderPresent);
  }

  Future<bool> isUserDataAvailable() async {


    print("isUserDataAvailable readboolvalue for is_MobileSignIn ${StorageUtils.readboolvalue(Preference.is_MobileSignIn)}");
    print("isUserDataAvailable readboolvalue for is_AppleSignIn ${StorageUtils.readboolvalue(Preference.is_AppleSignIn)}");
    print("isUserDataAvailable readboolvalue for is_GoogleSignIn ${StorageUtils.readboolvalue(Preference.is_GoogleSignIn)}");
    print("isUserDataAvailable readboolvalue for is_OnboardingComplete ${StorageUtils.readboolvalue(Preference.is_OnboardingComplete)}");


    bool is_MobileSignIn = StorageUtils.readboolvalue(Preference.is_MobileSignIn);
    bool is_AppleSignIn = StorageUtils.readboolvalue(Preference.is_AppleSignIn);
    bool is_GoogleSignIn = StorageUtils.readboolvalue(Preference.is_GoogleSignIn);
    String user_Name = StorageUtils.readvaluefromgetstorage(Preference.user_Name);
    String user_EmailAddress = StorageUtils.readvaluefromgetstorage(Preference.user_EmailAddress);
    String user_PhoneNumber = StorageUtils.readvaluefromgetstorage(Preference.user_PhoneNumber);
    String user_Gender = StorageUtils.readvaluefromgetstorage(Preference.user_Gender);
    print("is_AppleSignIn $is_AppleSignIn");
    print("is_GoogleSignIn $is_GoogleSignIn");
    print("is_MobileSignIn $is_MobileSignIn");
    print("user_Name $user_Name");
    print("user_EmailAddress $user_EmailAddress");
    print("user_PhoneNumber $user_PhoneNumber");
    print("user_Gender $user_Gender");
    if (is_MobileSignIn){
      return ((user_Name.length > 0) && (user_PhoneNumber.length > 0) && (user_Gender.length > 0));
    }else if (is_AppleSignIn || is_GoogleSignIn){
      return ((user_Name.length > 0) && (user_EmailAddress.length > 0) && (user_Gender.length > 0));
    }
    return false;
  }


  saveToLocalStorage(LoginUser userInfo) async {

    print("saveToLocalStorage id"+userInfo.id!);
    print("saveToLocalStorage name"+userInfo.firstName!);
    print("saveToLocalStorage emailAddress"+userInfo.emailAddress!);
    print("saveToLocalStorage phoneNumber"+userInfo.phoneNumber!);
    print("saveToLocalStorage profileImage"+userInfo.profileImage!);
    print("saveToLocalStorage gender"+userInfo.gender!);
    print("saveToLocalStorage readboolvalue for is_MobileSignIn ${StorageUtils.readboolvalue(Preference.is_MobileSignIn)}");
    print("saveToLocalStorage readboolvalue for is_AppleSignIn ${StorageUtils.readboolvalue(Preference.is_AppleSignIn)}");
    print("saveToLocalStorage readboolvalue for is_GoogleSignIn ${StorageUtils.readboolvalue(Preference.is_GoogleSignIn)}");
    print("saveToLocalStorage readboolvalue for is_OnboardingComplete ${StorageUtils.readboolvalue(Preference.is_OnboardingComplete)}");

    StorageUtils.writevalueinstorage(Preference.user_Firebase_id, userInfo.id ?? "");
    StorageUtils.writevalueinstorage(Preference.user_Name, userInfo.firstName ?? "");
    StorageUtils.writevalueinstorage(Preference.user_EmailAddress, userInfo.emailAddress ?? "");
    StorageUtils.writevalueinstorage(Preference.user_PhoneNumber, userInfo.phoneNumber ?? "");
    StorageUtils.writevalueinstorage(Preference.user_ProfileImage, userInfo.profileImage ?? "");
    StorageUtils.writevalueinstorage(Preference.user_Gender, userInfo.gender ?? "");

    print("saveToLocalStorage writevalueinstorage for user_Firebase_id ${StorageUtils.readvaluefromgetstorage(Preference.user_Firebase_id)}");
    print("saveToLocalStorage writevalueinstorage for user_Name ${StorageUtils.readvaluefromgetstorage(Preference.user_Name)}");
    print("saveToLocalStorage writevalueinstorage for user_EmailAddress ${StorageUtils.readvaluefromgetstorage(Preference.user_EmailAddress)}");
    print("saveToLocalStorage writevalueinstorage for user_PhoneNumber ${StorageUtils.readvaluefromgetstorage(Preference.user_PhoneNumber)}");
    print("saveToLocalStorage writevalueinstorage for user_ProfileImage ${StorageUtils.readvaluefromgetstorage(Preference.user_ProfileImage)}");
    print("saveToLocalStorage writevalueinstorage for user_Gender ${StorageUtils.readvaluefromgetstorage(Preference.user_Gender)}");

    // DocumentReference<Object?>? createdBy =  await getUserDocumentReferenceNew(FirebaseCollection.users, FirebaseAuth.instance.currentUser!.uid);
    // LocalUser inputLocalUser = LocalUser(name: userInfo.name!, user: userInfo, userRef: createdBy!);
    // StorageUtils.writeLocalUser(inputLocalUser);

  }

  removeFromLocalStorage(){



    // log("saveToLocalStorage user_Name "+StorageUtils.readvaluefromgetstorage(Preference.user_Name));
    // log("saveToLocalStorage user_EmailAddress "+StorageUtils.readvaluefromgetstorage(Preference.user_EmailAddress));
    // log("saveToLocalStorage user_ProfileImage "+StorageUtils.readvaluefromgetstorage(Preference.user_ProfileImage));
    // log("saveToLocalStorage user_Gender "+StorageUtils.readvaluefromgetstorage(Preference.user_Gender));
    // log("saveToLocalStorage is_GoogleSignIn "+StorageUtils.readboolvalue(Preference.is_GoogleSignIn).toString());
    // log("saveToLocalStorage is_MobileSignIn "+StorageUtils.readboolvalue(Preference.is_MobileSignIn).toString());
    // log("saveToLocalStorage is_AppleSignIn "+StorageUtils.readboolvalue(Preference.is_AppleSignIn).toString());

    StorageUtils.writevalueinstorage(Preference.user_Firebase_id, "");
    StorageUtils.writevalueinstorage(Preference.user_Name, "");
    StorageUtils.writevalueinstorage(Preference.user_EmailAddress, "");
    StorageUtils.writevalueinstorage(Preference.user_PhoneNumber, "");
    StorageUtils.writevalueinstorage(Preference.user_ProfileImage, "");
    StorageUtils.writevalueinstorage(Preference.user_Gender, "");
    StorageUtils.writevalueinstorage(Preference.verificationId, "");

    StorageUtils.writeboolvalue(Preference.is_GoogleSignIn, false);
    StorageUtils.writeboolvalue(Preference.is_MobileSignIn, false);
    StorageUtils.writeboolvalue(Preference.is_AppleSignIn, false);
    StorageUtils.writeboolvalue(Preference.is_OnboardingComplete, false);

    Get.deleteAll();

  }

}
