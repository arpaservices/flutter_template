
import 'package:get/get_instance/src/bindings_interface.dart';

import '../dependecies.dart';
import '../source_binding.dart';

class MobileOtpBinding extends Bindings {
  @override
  void dependencies() {
    bindingDataSource();
    bindingConnectionManagerController();
    bindingMobileOtpController();
  }
}