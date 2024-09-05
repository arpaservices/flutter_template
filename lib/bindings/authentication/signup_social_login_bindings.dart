
import 'package:get/get.dart';

import '../dependecies.dart';
import '../source_binding.dart';


class SignUpSocialLoginBinding extends Bindings {
  @override
  void dependencies() {
    bindingDataSource();
    bindingConnectionManagerController();
    bindingSignUpSocialLoginController();
  }
}
