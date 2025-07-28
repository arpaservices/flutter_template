import 'dart:convert';
import 'dart:io';
//
import 'dart:convert';
import 'dart:io';

Future<void> updateInfoPlist() async {
  final jsonPath = 'assets/app_setting/app_services.json';
  final plistPath = 'ios/Runner/Info.plist';

  if (!File(jsonPath).existsSync() || !File(plistPath).existsSync()) {
    print("❌ Error: JSON or Info.plist not found.");
    exit(1);
  }

  // Read and parse JSON
  final jsonString = File(jsonPath).readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(jsonString);

  final appName = data['app_info']['app_name'] ?? 'DefaultApp';
  final admobAppId =
      data['credentials']?['admob_ios_pub_id']?.toString().trim();

  print("🔧 Updating Info.plist with:");
  print("➡️ App Name: $appName");
  print("➡️ AdMob iOS App ID: $admobAppId");

  // Read Info.plist content
  var plistContent = File(plistPath).readAsStringSync();

  // Update App Name
  final appNameRegex = RegExp(
    r'<key>(CFBundleDisplayName|CFBundleName)</key>\s*<string>[^<]*</string>',
  );

  if (appNameRegex.hasMatch(plistContent)) {
    plistContent = plistContent.replaceAllMapped(appNameRegex, (match) {
      final key = match.group(1);
      return '<key>$key</key>\n\t<string>$appName</string>';
    });
    print("✅ App name updated.");
  } else {
    print("⚠️ App name key not found. Inserting CFBundleDisplayName.");
    final insertionPoint = plistContent.indexOf('</dict>');
    plistContent = plistContent.substring(0, insertionPoint) +
        '\n\t<key>CFBundleDisplayName</key>\n\t<string>$appName</string>\n' +
        plistContent.substring(insertionPoint);
  }

  // Update AdMob iOS App ID
  if (admobAppId != null && admobAppId.isNotEmpty) {
    final admobKeyRegex = RegExp(
      r'<key>GADApplicationIdentifier</key>\s*<string>[^<]*</string>',
    );

    if (admobKeyRegex.hasMatch(plistContent)) {
      plistContent = plistContent.replaceAllMapped(admobKeyRegex, (match) {
        return '<key>GADApplicationIdentifier</key>\n\t<string>$admobAppId</string>';
      });
      print("✅ AdMob App ID updated.");
    } else {
      print("⚠️ AdMob key not found. Inserting GADApplicationIdentifier.");
      final insertionPoint = plistContent.indexOf('</dict>');
      plistContent = plistContent.substring(0, insertionPoint) +
          '\n\t<key>GADApplicationIdentifier</key>\n\t<string>$admobAppId</string>\n' +
          plistContent.substring(insertionPoint);
    }
  } else {
    print("⚠️ No AdMob App ID found in JSON.");
  }

  // Save changes
  File(plistPath).writeAsStringSync(plistContent);
  print("✅ Info.plist updated successfully!");
}


