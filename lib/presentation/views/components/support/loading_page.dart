import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../presentation/controllers/general/loading_page_controller.dart';

class LoadingScreen extends GetView<LoadingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Container();
    });
  }
}
