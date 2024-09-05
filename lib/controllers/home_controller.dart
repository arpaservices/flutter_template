import 'package:get/get.dart';

import '../services/localStorage/storage_utils.dart';
import '../utils/core/app_strings.dart';
import '../utils/network/DataSource.dart';
import 'connection/connection_manager_controller.dart';

class HomeController extends GetxController {
  DataSourceClass? dataSourceSuperApp;

  HomeController({this.dataSourceSuperApp});

  final ConnectionManagerController connController =
  Get.find<ConnectionManagerController>();


  RxInt currentPage = 0.obs;
  @override
  void onInit() {
    StorageUtils.writeboolvalue(Preference.is_OnboardingComplete, true);
    super.onInit();
  }
}