
import 'package:flutter_template/services//Firebase/firebase_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/firebase/notification_data_model.dart';
import '../../utils/core/app_strings.dart';
import '../localStorage/storage_utils.dart';


class FirebaseConfig {
  var userId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference DBRef = FirebaseDatabase.instance.ref(FirebaseCollection.userInfo);

  Rx<NotificationDataModel> notifModel = NotificationDataModel().obs;
  RxBool showNotification = false.obs;


  getCurrentUser() async {
    final User user = _auth.currentUser!;
  }

  setUpFirebase() {
    print("setUpFirebase");
    FirebaseMessaging.instance.getToken().then((value) {
      if (value != null){
        print("FirebaseMessaging Token");
        print(value);
        StorageUtils.writevalueinstorage(Preference.fcm_token, value);
      }
    });
  }

  setUpNotification() async{
    print("setUpFirebaseNotification");
    FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    final firebaseMessaging = FirebaseNotification();
    firebaseMessaging.setNotifications();
    firebaseMessaging.remoteMsgCtrl.stream.listen(_changeData);
  }

  Future<bool> checkUpNotification() async{
    print("checkUpNotification");
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.denied || settings.authorizationStatus == AuthorizationStatus.notDetermined) {
      return false;
    }
    return true;
  }

  Future<bool> checkUpCameraPermission() async{

    var status = await Permission.camera.status;
    print("checkUpCameraPermission "+status.toString());
    if (status.isDenied || status.isPermanentlyDenied || status.isRestricted) {
      return false;
    }else if (status.isGranted) {
      return true;
    }
    return false;
  }

  _changeData(RemoteMessage msg) {
    notifModel.value = NotificationDataModel.fromJson(msg.data);
    if (notifModel.value?.title.toString() != "") {
      showNotification.value = true;
    }
  }

}
