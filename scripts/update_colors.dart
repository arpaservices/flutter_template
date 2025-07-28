import 'dart:convert';
import 'dart:io';

Future<void> updateColor() async {
  final jsonPath = 'assets/app_setting/app_services.json';
  final colorsPath = 'lib/utils/core/constant/color.dart';

  // Check if files exist
  if (!File(jsonPath).existsSync() || !File(colorsPath).existsSync()) {
    print("Error: JSON or colors.dart not found.");
    exit(1);
  }

  // Read and parse JSON
  final jsonString = File(jsonPath).readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(jsonString);

  final primaryColorValue =
      data['app_color']['primary_color']?.toString().trim();
  final secondaryColorValue =
      data['app_color']['secondary_color']?.toString().trim();
  final mainColorValue = data['app_color']['main_color']?.toString().trim();

  if (primaryColorValue == null ||
      secondaryColorValue == null ||
      mainColorValue == null) {
    print("Error: Some color values are missing in JSON.");
    exit(1);
  }

  String primaryColor = convertColorToFlutterFormat(primaryColorValue);
  String secondaryColor = convertColorToFlutterFormat(secondaryColorValue);
  String mainColor = convertColorToFlutterFormat(mainColorValue);
  print(
      "Updating colors.dart with Primary: $primaryColor, Secondary: $secondaryColor, Main: $mainColor");

  // Read colors.dart content
  var colorsContent = File(colorsPath).readAsStringSync();

  // Regular expressions to match the color values
  final primaryRegex = RegExp(r'const primaryColor\s*=\s*Color\([^\)]*\);');
  final secondaryRegex = RegExp(r'const secondaryColor\s*=\s*Color\([^\)]*\);');
  final mainRegex = RegExp(r'const mainColor\s*=\s*Color\([^\)]*\);');

  // Replace colors using regex
  colorsContent = colorsContent
      .replaceAllMapped(
          primaryRegex, (match) => 'const primaryColor = Color($primaryColor);')
      .replaceAllMapped(secondaryRegex,
          (match) => 'const secondaryColor = Color($secondaryColor);')
      .replaceAllMapped(
          mainRegex, (match) => 'const mainColor = Color($mainColor);');

  // Write the updated content to colors.dart
  File(colorsPath).writeAsStringSync(colorsContent);
  print("✅ colors.dart updated with new colors.");
}

String convertColorToFlutterFormat(String color) {
  // Remove '#' if it exists and ensure the string is 6 or 8 characters
  String hex = color.replaceAll('#', '');

  // If hex is 6 characters, add 'ff' as the alpha channel (fully opaque)
  if (hex.length == 6) {
    hex = 'ff$hex';
  }

  return '0x$hex';
}
