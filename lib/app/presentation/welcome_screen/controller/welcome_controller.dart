import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var animationStarted = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Delay sedikit agar Flutter sempat membangun UI
    Future.delayed(const Duration(milliseconds: 1000), () {
      animationStarted.value = true;
    });
  }
}
