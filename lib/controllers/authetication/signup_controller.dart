import 'dart:io';

import 'package:absaly/network/DataSource.dart';
import 'package:get/get.dart';

import '../connection_manager_controller.dart';


class SignUpController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  SignUpController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();

  @override
  void onInit() {
    getData();
    super.onInit();
  }


  void getData() async {
    try {
      if (connController.connectionType.value == 0) {
        print("TestController - No internet conn>>>");
      } else {
        print("TestController - Active internet conn");
      }
    } on SocketException catch (e) {
      print('SocketException Error: $e');
    } catch (e) {
      print(e);
    } finally {}
  }
}