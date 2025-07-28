import 'dart:convert';
import 'dart:io';

Future<void> updateContants() async {
  print('In Update Constant');
  final jsonPath = 'assets/app_setting/app_services.json';
  final constantsPath = 'lib/utils/core/constant/constants.dart';

  if (!File(jsonPath).existsSync() || !File(constantsPath).existsSync()) {
    print("❌ Error: JSON or constants.dart not found.");
    exit(1);
  }

  final jsonString = File(jsonPath).readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(jsonString);

  final appInfo = data['app_info'] ?? {};
  final credentials = data['credentials'] ?? {};

  final newBaseUrl = appInfo['app_base_url']?.toString().trim();
  final newAppName = appInfo['app_name']?.toString().trim();
  final newSvaraAppId = credentials['svara_app_id']?.toString().trim();
  final newSvaraSecretKey = credentials['svara_secret_key']?.toString().trim();

  if (newBaseUrl == null || newBaseUrl.isEmpty) {
    print("❌ Error: Base URL is missing in JSON.");
    exit(1);
  }
  if (newAppName == null || newAppName.isEmpty) {
    print("❌ Error: App name is missing in JSON.");
    exit(1);
  }

  print("🔄 Updating constants.dart with:");
  print("➡️ Base URL: $newBaseUrl");
  print("➡️ App Name: $newAppName");
  print("➡️ Svara App ID: $newSvaraAppId");
  print("➡️ Svara Secret Key: $newSvaraSecretKey");

  var constantsContent = File(constantsPath).readAsStringSync();

  // Base URL
  final baseUrlRegex = RegExp(
      r'(static const String SUPER_STAR_APP_BASE_URL\s*=\s*")[^"]*(";?)');
  constantsContent = constantsContent.replaceAllMapped(baseUrlRegex, (match) {
    return '${match.group(1)}$newBaseUrl${match.group(2)}';
  });

  // App Name
  final appNameRegex =
      RegExp(r'(static const String APP_NAME\s*=\s*")[^"]*(";?)');
  constantsContent = constantsContent.replaceAllMapped(appNameRegex, (match) {
    return '${match.group(1)}$newAppName${match.group(2)}';
  });

  // SVARA_APP_ID
  if (newSvaraAppId != null && newSvaraAppId.isNotEmpty) {
    final svaraIdRegex =
        RegExp(r'(static const String SVARA_APP_ID\s*=\s*")[^"]*(";?)');
    if (svaraIdRegex.hasMatch(constantsContent)) {
      constantsContent =
          constantsContent.replaceAllMapped(svaraIdRegex, (match) {
        return '${match.group(1)}$newSvaraAppId${match.group(2)}';
      });
      print("✅ SVARA_APP_ID updated.");
    } else {
      print("❌ SVARA_APP_ID not found in constants.dart.");
    }
  }

  // SVARA_SCERET_KEY
  if (newSvaraSecretKey != null && newSvaraSecretKey.isNotEmpty) {
    final svaraKeyRegex =
        RegExp(r'(static const String SVARA_SCERET_KEY\s*=\s*")[^"]*(";?)');
    if (svaraKeyRegex.hasMatch(constantsContent)) {
      constantsContent =
          constantsContent.replaceAllMapped(svaraKeyRegex, (match) {
        return '${match.group(1)}$newSvaraSecretKey${match.group(2)}';
      });
      print("✅ SVARA_SCERET_KEY updated.");
    } else {
      print("❌ SVARA_SCERET_KEY not found in constants.dart.");
    }
  }

  // Save the file
  File(constantsPath).writeAsStringSync(constantsContent);
  print("✅ constants.dart updated successfully.");
}


