// file: ui_helper.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UIHelper {
  // TextStyle with responsive font size
  static TextStyle responsiveTextStyle(
      {required Color color,
      FontWeight? fontWeight,
      required double webFontSize,
      required double mobileFontSize,
      TextDecoration? decoration,
      TextOverflow? overflow}) {
    return TextStyle(
        color: color,
        fontSize: kIsWeb ? webFontSize : mobileFontSize,
        fontWeight: fontWeight,
        overflow: overflow,
        decoration: decoration);
  }

  static double iconSize(
      {required double iconWebSized, required double iconMobileSized}) {
    if (kIsWeb) {
      return iconWebSized;
    }
    return iconMobileSized;
  }

  static double containerSize(
      {required double webContainerSized,
      required double mobileContainerSized}) {
    if (kIsWeb) {
      return webContainerSized;
    }
    return mobileContainerSized;
  }
}
