
// import 'dart:html';
import 'dart:developer';
import 'dart:io';

import 'package:absaly/data/repositories/user_repository.dart';
import 'package:absaly/network/DataSource.dart';
import 'package:absaly/utils/Services/storage_utils.dart';
import 'package:absaly/utils/supportUi/comman_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/models/firebase/api_response.dart';
import '../../data/models/firebase/user_model.dart';
import '../../firebaseUtilities/firestore/constants/auditFields.dart';
import '../../route/app_routes.dart';
import '../../screens/app_constants.dart';
import '../../utils/Firebase/firebase_config.dart';
import '../../utils/Services/authentication.dart';
import '../../utils/Services/regexValidations.dart';
import '../../utils/constants/app_enums.dart';
import '../connection_manager_controller.dart';


class SignUpProfileController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  SignUpProfileController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  List<Gender> genderList = [Gender.male,Gender.female,Gender.other].obs;

  // RxString genderSelected = "".obs;
  RxString genderSelected = GenderEnum.getGender(Gender.blank).obs;
  // RxInt genderSelectedIndex = 100.obs;

  // RxString imageIcon = "".obs;
  RxString imageIcon = "".obs;
  // RxString imageIconDefault = "assets/image/user_profile.png".obs;
  RxString imageIconDefault = "assets/image/men_image.png".obs;

  RxString authState = "".obs;
  RxString authErrorMessage = "".obs;

  LoginUser? userModel;
  final UserRepository _repository = UserRepository();

  // late TextEditingController firstNameText;
  late TextEditingController firstNameText = TextEditingController();
  late TextEditingController lastNameText = TextEditingController();
  late TextEditingController emailAddressText = TextEditingController();
  late TextEditingController phoneNumberText = TextEditingController();

  RxBool isGoogleSignIn = false.obs;
  RxBool isMobileSignIn = false.obs;
  RxBool isAppleSignIn = false.obs;

  final AuthServices _authServices = AuthServices();

  @override
  void onInit() {
    super.onInit();
    userModel = Get.arguments[AppArg.login_user] as LoginUser;
    if (userModel != null){
      log("userModel ${userModel!.emailAddress}");
      log("userModel ${userModel!.phoneNumber}");
      log("userModel ${userModel!.id}");
    }
    initializeTxtController();
  }

  void initializeTxtController() {
    isGoogleSignIn.value =
        StorageUtils.readboolvalue(Preference.is_GoogleSignIn);
    isMobileSignIn.value =
        StorageUtils.readboolvalue(Preference.is_MobileSignIn);
    isAppleSignIn.value = StorageUtils.readboolvalue(Preference.is_AppleSignIn);

    if (StorageUtils
        .readvaluefromgetstorage(Preference.user_Name).isNotEmpty) {
      firstNameText.text =
          StorageUtils.readvaluefromgetstorage(Preference.user_Name);
    }
    if (StorageUtils
        .readvaluefromgetstorage(Preference.user_EmailAddress).isNotEmpty) {
      emailAddressText.text =
          StorageUtils.readvaluefromgetstorage(Preference.user_EmailAddress);
    }
    if (StorageUtils
        .readvaluefromgetstorage(Preference.user_PhoneNumber).isNotEmpty && isMobileSignIn.value) {
      phoneNumberText.text =
          StorageUtils.readvaluefromgetstorage(Preference.user_PhoneNumber);
    }
    if (StorageUtils
        .readvaluefromgetstorage(Preference.user_Gender).isNotEmpty) {
      genderSelected.value =
          StorageUtils.readvaluefromgetstorage(Preference.user_Gender);
    }
    if (StorageUtils
        .readvaluefromgetstorage(Preference.user_ProfileImage).isNotEmpty) {
      imageIcon.value =
          StorageUtils.readvaluefromgetstorage(Preference.user_ProfileImage);
    }
  }

  genderSelectedClick(int index){

    genderSelected.value = GenderEnum.getGender(genderList[index]);
    log("genderSelectedClick ${GenderEnum.getGender(genderList[index])}");


  }

  saveProfileData(BuildContext context) async {

    authErrorMessage.value = "";

    String firstName = firstNameText.text;
    String lastName = lastNameText.text;
    String emailAddress = emailAddressText.text;

    // if (firstName.length == 0 || lastName.length == 0 || emailAddress.length == 0) {
    if (firstName.isEmpty || emailAddress.isEmpty) {
      authErrorMessage.value = "Add Proper Details";
      return;
    }
    if (genderSelected.value.isEmpty){
      authErrorMessage.value = "Please select gender";
      return;
    }
    if (!validateEmail(emailAddressText.text)){
      authErrorMessage.value = "Please enter valid email id";
      return;
    }

    if (userModel != null){
      log("userModel ${userModel!.emailAddress}");
      log("userModel ${userModel!.phoneNumber}");
      log("userModel ${userModel!.id}");
    }

    CommanDialog.showLoading();
    LoginUser newUser = LoginUser(
      id: userModel!.id,
      firstName: firstName ,
      lastName: lastName,
      profileImage: imageIcon.value,
      phoneNumber: userModel!.phoneNumber,
      emailAddress: emailAddress,
      gender: genderSelected.value,
      isDeleted: false,
    );

    CommanDialog.showLoading(title: "Loading");
    ApiResponse<LoginUser>? response = await _repository.createNewUser(newUser);
    if (response != null){
      log("response success ${response.status}");
      log("response success ${response.message}");
      log("response success ${response.data}");
      if (response.status.toLowerCase() == "success") {
        if (response.data!.id != null && response.data!.id!.isNotEmpty ){
          updateAuditFields(FirebaseCollection.users, response.data!.id!);
        }
        await _authServices.saveToLocalStorage(response.data!);
        CommanDialog.hideLoading();
        FirebaseConfig config = FirebaseConfig();
        bool isSetUp = await config.checkUpNotification();
        if (!isSetUp) {
          Get.toNamed(AppRoutes.NOTIFICATION_PERMISSION);
        } else{
          Get.toNamed(AppRoutes.HOME);
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


  void profileSettingPressed(BuildContext context) async {
    // final firebaseStorage = FirebaseStorage.instance;
    FirebaseStorage storage = FirebaseStorage.instance;
    final XFile? image;
    try {
      FirebaseConfig config = FirebaseConfig();
      bool isGalleryStatus = await config.checkUpCameraPermission();
      if (!isGalleryStatus) {
        // openAppSettings();
        await Permission.camera.status;
      } else{
        image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image == null) return;
        File file = File(image.path);

        String idStr = StorageUtils.readvaluefromgetstorage(Preference.user_Firebase_id);

        Reference ref = storage.ref().child('images/${idStr}');
        UploadTask uploadTask = ref.putFile(file);
        uploadTask.then((res) {
          res.ref.getDownloadURL();
          log("getDownloadURL");
          log(res.ref.getDownloadURL().toString());
        });

      }
    } on Exception catch (e) {
      // TODO
      Logger logger = Logger();
      logger.e(e.toString());
    }
  }
}


