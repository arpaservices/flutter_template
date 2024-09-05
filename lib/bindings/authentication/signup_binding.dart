
import 'package:get/get.dart';

import '../dependecies.dart';
import '../source_binding.dart';



class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    bindingDataSource();
    bindingConnectionManagerController();
    bindingSignUpController();
  }
}
