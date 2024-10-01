import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
/// A utility class for retrieving device screen dimensions in logical pixels.
///
/// The `DeviceInfo` class provides methods to get the height and width of the device's screen
/// in logical pixels, considering the device's pixel ratio. These methods help in building
/// responsive layouts by providing accurate screen dimensions.
class DeviceInfo {

  /// Returns the height of the device's screen in logical pixels.
  ///
  /// The method calculates the screen height by dividing the physical screen height
  /// (in pixels) by the device's pixel ratio. This conversion is necessary because
  /// Flutter works with logical pixels, and this method ensures proper scaling
  /// across different devices.
  ///
  /// ### Example:
  /// ```dart
  /// double height = DeviceInfo.deviceHeight();
  /// // Returns the screen height in logical pixels.
  /// ```
  ///
  /// This method can be used to get the screen height dynamically, helping in
  /// creating responsive layouts.
  static double deviceHeight() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    double physicalHeight = view.physicalSize.height;
    double devicePixelRatio = view.devicePixelRatio;
    double screenHeight = physicalHeight / devicePixelRatio;
    // print("screenHeight " + screenHeight.toString());
    return screenHeight;
  }

  /// Returns the width of the device's screen in logical pixels.
  ///
  /// The method calculates the screen width by dividing the physical screen width
  /// (in pixels) by the device's pixel ratio. This provides the logical width, which
  /// accounts for pixel density and allows for consistent UI across different devices.
  ///
  /// ### Example:
  /// ```dart
  /// double width = DeviceInfo.deviceWidth();
  /// // Returns the screen width in logical pixels.
  /// ```
  ///
  /// This method helps retrieve the screen width, which is useful for responsive
  /// layout design and handling UI elements dynamically.
  static double deviceWidth() {
    FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
    double physicalWidth = view.physicalSize.width;
    double devicePixelRatio = view.devicePixelRatio;
    double screenWidth = physicalWidth / devicePixelRatio;
    // print("screenWidth " + screenWidth.toString());
    return screenWidth;
  }
}