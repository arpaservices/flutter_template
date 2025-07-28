import 'package:get/get_navigation/src/routes/get_route.dart';

import '../presentation/bindings/splash_screen_binding.dart';
import '../presentation/views/intro/splash_screen.dart';
import 'app_routes.dart';



class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashScreenBinding(),
    ),




  ];
}
