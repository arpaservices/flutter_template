
import 'package:get/get.dart';

import '../dependecies.dart';
import '../source_binding.dart';



class AuthBinding extends Bindings {
  @override
  void dependencies() {
    bindingDataSource();
    bindingConnectionManagerController();
    bindingAuthController();
  }
}
