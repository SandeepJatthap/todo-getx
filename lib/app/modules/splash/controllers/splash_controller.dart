import 'package:get/get.dart';
import 'package:todo/app/routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addDelay() async {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAllNamed(Routes.HOME);
    });
  }
}
