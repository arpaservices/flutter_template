import 'package:get/get.dart';
import '../controllers/intro/splash_screen_controller.dart';
import '../dependency/dependency_injector.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    bindController<SplashController>(() => SplashController());
  }
}
