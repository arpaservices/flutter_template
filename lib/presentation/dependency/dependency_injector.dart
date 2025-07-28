import 'package:get/get.dart';

void bindController<T>(T Function() controller) {
  Get.lazyPut<T>(controller);
}
