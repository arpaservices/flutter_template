import 'dart:io';
import 'update_build_gradle.dart';
import 'update_constants.dart';
import 'update_colors.dart';
import 'update_info_plist.dart';
import 'update_manifest.dart';

Future<void> main() async {
  final jsonPath = 'assets/app_setting/app_services.json';

  if (!File(jsonPath).existsSync()) {
    print("❗ Error: JSON file not found at $jsonPath");
    exit(1);
  }

  try {
    print("🚀 Starting update process...");

    // Call each script's function
    await updateManifest();
    await updateBuildGradle();
    await updateInfoPlist();
    await updateContants();
    await updateColor();

    print("✅ All updates completed successfully!");
  } catch (e) {
    print("❗ Error: $e");
  }
}
