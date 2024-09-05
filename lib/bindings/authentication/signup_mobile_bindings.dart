
import 'package:get/get.dart';

import '../source_binding.dart';

import '../dependecies.dart';
import '../source_binding.dart';


class SignUpMobileBinding extends Bindings {
  @override
  void dependencies() {
    bindingDataSource();
    bindingConnectionManagerController();
    bindingSignUpMobileController();
  }
}
