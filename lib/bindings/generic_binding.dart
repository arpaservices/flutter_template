import 'package:get/get.dart';

class GenericBinding<T extends GetxController> extends Bindings {
  final T controller;

  GenericBinding(this.controller);

  @override
  void dependencies() {
    Get.lazyPut<T>(() => controller);
  }
}