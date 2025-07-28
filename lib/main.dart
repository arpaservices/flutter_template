import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'presentation/bindings/initial_binding.dart';
import 'presentation/controllers/general/loading_page_controller.dart';
import 'presentation/views/components/support/loading_page.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'utils/core/constant/assets.dart';
import 'utils/core/constant/string.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );



    //
    // await FirebaseAppCheck.instance.activate(
    //   androidProvider: AndroidProvider.playIntegrity,
    // );
    // await Get.put(NotificationService()).init();
    // await FirebaseMessaging.instance.subscribeToTopic("all_user");


  final String langCode = await loadAndApplyLanguagePreferenceSafely();
  runApp(MyApp(defaultLanguage: langCode));
}

Future<String> loadAndApplyLanguagePreferenceSafely() async {
  try {
    final String jsonString =
    await rootBundle.loadString(Assets.getAppServices());
    final Map<String, dynamic> data = jsonDecode(jsonString);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final code =
        prefs.getString('l10n') ?? data['app_info']['default_language'] ?? 'en';

    Get.updateLocale(Locale(code));
    log("Applied language: $code");

    return code;
  } catch (e) {
    log("Error loading language preference: $e");
    return 'en'; // Fallback to English
  }
}

class MyApp extends StatefulWidget {
  final String defaultLanguage;
  const MyApp({super.key, required this.defaultLanguage});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    log("initState");
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    log("dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _loader = Get.put(LoadingController());

    String initialRoute =  AppRoutes.SPLASH;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      initialRoute: initialRoute,
      initialBinding: InitialBinding(),
      getPages: AppPages.list,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return Stack(
          children: [
            Obx(() {
              return Opacity(
                opacity: (_loader.isLoading.value == true) ? .5 : 1,
                child: child ?? SizedBox(),
              );
            }),
            LoadingScreen(),
          ],
        );
      },

      theme: ThemeData(
        fontFamily: "Urbanist",
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 3.0),
        ),
      ),
    );
  }
}
