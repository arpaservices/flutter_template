import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/core/constant/assets.dart';
import '../../models/users/user_data.dart';


String _USER_DATA_KEY = "userData";
const String notificationCountKey = 'notification_count';
const String languagePreferenceKey = "l10n";
var languageCode;
void saveProfileDataLocally(UserData userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Create a Map to store the user data
  Map<String, dynamic> userDataJson = userData.toJson();

  // Convert the Map to a JSON string
  String jsonData = json.encode(userDataJson);

  // Store the JSON string in SharedPreferences
  await prefs.setString(_USER_DATA_KEY, jsonData);
}

Future<UserData> getProfileDataLocally() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJsonData = prefs.getString(_USER_DATA_KEY);
  Map<String, dynamic> userData = jsonDecode(userJsonData!);
  print('userData: ${userData.toString()}');
  return UserData.fromJson(userData);
}

Future<bool> isUserDataAvailable() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Check if the 'userData' key exists in SharedPreferences
  return prefs.containsKey(_USER_DATA_KEY);
}

Future<void> clearAllLocalData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear(); // This will remove all stored data in SharedPreferences
}

// Save the selected language to local storage
Future<void> saveLanguageDataLocally(String languageCode) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(languagePreferenceKey, languageCode);
}

/// Load and apply saved language preference
Future<void> loadAndApplyLanguagePreference() async {
  final String jsonString =
      await rootBundle.loadString(Assets.getAppServices());
  final Map<String, dynamic> data = jsonDecode(jsonString);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  languageCode = prefs.getString('l10n') ??
      data['app_info']['default_language']; // Default to English if not set
  Get.updateLocale(Locale(languageCode));
  print("Applied language: $languageCode");
}
