import 'dart:convert';
import 'dart:io';

import 'dart:convert';
import 'dart:io';

Future<void> updateManifest() async {
  final jsonPath = 'assets/app_setting/app_services.json';
  final manifestPath = 'android/app/src/main/AndroidManifest.xml';

  if (!File(jsonPath).existsSync() || !File(manifestPath).existsSync()) {
    print("❌ Error: JSON or AndroidManifest.xml not found.");
    exit(1);
  }

  final jsonString = File(jsonPath).readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(jsonString);
  final appInfo = data['app_info'] ?? {};
  final credentials = data['credentials'] ?? {};

  final appName = appInfo['app_name'] ?? 'DefaultApp';
  final admobAppId = credentials['admob_android_pub_id']?.toString().trim();

  print("🔧 Updating AndroidManifest.xml:");
  print("➡️ App Name: $appName");
  print("➡️ AdMob App ID: $admobAppId");

  var manifestContent = File(manifestPath).readAsStringSync();

  // Update android:label
  final appNameRegex = RegExp(r'android:label="[^"]*"');
  manifestContent =
      manifestContent.replaceAll(appNameRegex, 'android:label="$appName"');

  // Update AdMob App ID
  if (admobAppId != null && admobAppId.isNotEmpty) {
    final admobMetaRegex = RegExp(
      r'<meta-data\s+android:name="com\.google\.android\.gms\.ads\.APPLICATION_ID"\s+android:value="[^"]*"\s*/>',
    );

    final newMeta =
        '<meta-data android:name="com.google.android.gms.ads.APPLICATION_ID" android:value="$admobAppId"/>';

    if (admobMetaRegex.hasMatch(manifestContent)) {
      manifestContent = manifestContent.replaceAll(admobMetaRegex, newMeta);
      print("✅ AdMob App ID replaced successfully.");
    } else {
      // If meta tag not found, insert it inside <application> tag
      final appTagRegex = RegExp(r'(<application[^>]*>)');
      if (appTagRegex.hasMatch(manifestContent)) {
        manifestContent = manifestContent.replaceFirstMapped(
          appTagRegex,
          (match) => '${match.group(1)}\n        $newMeta',
        );
        print("✅ AdMob App ID inserted inside <application> tag.");
      } else {
        print("❌ <application> tag not found to insert AdMob ID.");
      }
    }
  } else {
    print("⚠️ AdMob App ID not provided in JSON.");
  }

  // Write updated manifest
  File(manifestPath).writeAsStringSync(manifestContent);
  print("✅ AndroidManifest.xml updated successfully!");
}


