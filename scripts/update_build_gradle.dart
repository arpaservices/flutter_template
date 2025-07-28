import 'dart:convert';
import 'dart:io';

Future<void> updateBuildGradle() async {
  final jsonPath = 'assets/app_setting/app_services.json';
  final gradlePath = 'android/app/build.gradle';
  final mainActivityPath =
      'android/app/src/main/kotlin/com/example/super_star/MainActivity.kt';

  // Check if files exist
  if (!File(jsonPath).existsSync() ||
      !File(gradlePath).existsSync() ||
      !File(mainActivityPath).existsSync()) {
    print("Error: JSON, build.gradle, or MainActivity.kt not found.");
    exit(1);
  }

  // Read and parse JSON
  final jsonString = File(jsonPath).readAsStringSync();
  final Map<String, dynamic> data = jsonDecode(jsonString);
  final packageName = data['app_info']['package_name'] ?? 'com.example.default';

  print(
      "Updating build.gradle, MainActivity.kt with package name (namespace) and applicationId: $packageName");

  // Read build.gradle
  var gradleContent = File(gradlePath).readAsStringSync();

  // Regular expressions
  final namespaceRegex = RegExp(r'namespace\s*=?\s*"[^"]*"');
  final applicationIdRegex = RegExp(r'applicationId\s*=?\s*"[^"]*"');

  // Update namespace
  if (namespaceRegex.hasMatch(gradleContent)) {
    gradleContent =
        gradleContent.replaceAll(namespaceRegex, 'namespace = "$packageName"');
    print("Namespace updated successfully to: $packageName");
  } else {
    print("Namespace not found. Adding it to the build.gradle.");
    gradleContent = gradleContent.replaceFirst(
      'android {',
      'android {\n    namespace = "$packageName"',
    );
  }

  // Update applicationId
  if (applicationIdRegex.hasMatch(gradleContent)) {
    gradleContent = gradleContent.replaceAll(
        applicationIdRegex, 'applicationId "$packageName"');
    print("ApplicationId updated successfully to: $packageName");
  } else {
    print(
        "ApplicationId not found. Please check your build.gradle configuration.");
  }

  File(gradlePath).writeAsStringSync(gradleContent);

  // Update MainActivity.kt
  var mainActivityContent = File(mainActivityPath).readAsStringSync();
  final packageRegex = RegExp(r'package\s+[\w.]+');
  if (packageRegex.hasMatch(mainActivityContent)) {
    mainActivityContent =
        mainActivityContent.replaceAll(packageRegex, 'package $packageName');
    print("MainActivity.kt package name updated successfully to: $packageName");
  } else {
    print("Package declaration not found in MainActivity.kt.");
  }

  File(mainActivityPath).writeAsStringSync(mainActivityContent);

  print("✅ Build.gradle and  MainActivity.kt Updated successfully!");
}
