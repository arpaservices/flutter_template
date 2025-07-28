import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../../utils/core/constant/color.dart';

void showCommonSnackBar(String title, String message) {
  Get.snackbar(title, message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      backgroundColor: mainColor,
      colorText: mainColor);
}
