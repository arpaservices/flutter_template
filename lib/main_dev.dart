import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/routes/app_pages.dart';
import 'package:flutter_template/routes/app_routes.dart';
import 'package:flutter_template/services/Firebase/firebase_config.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bindings/generic_binding.dart';
import 'controllers/splash_controller.dart';
import 'firebase_options.dart';
import 'firebase_options_dev.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.camera.request();
  await Permission.microphone.request();
  await Permission.storage.request();
  await GetStorage.init();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptionsDev.currentPlatform,
  // );

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  print("appName "+appName);
  print("packageName "+packageName);
  if (Platform.isAndroid){
    bool isDev = appName.toLowerCase().contains("dev") || packageName.toLowerCase().contains("dev");
    print(isDev ? "iOS Dev Environment" : "iOS Environment");
    await Firebase.initializeApp(
      options: isDev ? DefaultFirebaseOptionsDev.currentPlatform : DefaultFirebaseOptions.currentPlatform,
    );
  }else if (Platform.isIOS){
    bool isDev = appName.toLowerCase().contains("dev") || packageName.toLowerCase().contains("dev");
    print(isDev ? "iOS Dev Environment" : "iOS Environment");
    await Firebase.initializeApp(
      options: isDev ? DefaultFirebaseOptionsDev.currentPlatform : DefaultFirebaseOptions.currentPlatform,
    );
  }
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  /*
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  // Hive.registerAdapter(LocalUserAdapter());
  await Hive.openBox<LocalUser>('localUserBox');
*/
  // await Hive.openBox<LocalUser>('localUserBox');

  runApp(MyAppDev());
}

class MyAppDev extends StatelessWidget with WidgetsBindingObserver {
  @override
  void initState() {
    print("initState");
    FirebaseConfig config = FirebaseConfig();
    config.setUpFirebase();
    config.setUpNotification();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    print("dispose");
    WidgetsBinding.instance.removeObserver(this);
  }

  Widget build(BuildContext context) {
    initState();
    return PopScope(
      canPop : false,
      child: GetMaterialApp(
        title: 'Template',
        theme: ThemeData(
            fontFamily: RUBIK_FONT
        ),
        // initialBinding: AuthBinding(),
        // initialRoute: AppRoutes.HOME,
        initialBinding: GenericBinding(SplashController()),
        initialRoute: AppRoutes.SPLASH,
        // initialBinding: AuthBinding(),
        // initialRoute: AppRoutes.NOTIFICATION_PERMISSION,
        getPages: AppPages.list,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
      ),
    );
  }
}
