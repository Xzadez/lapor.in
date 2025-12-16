import 'package:get/get.dart';
import 'package:laporin/app/presentation/profile_page_screen/controller/profile_page_controller.dart';



class ProfilePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfilePageController>(
      () => ProfilePageController(),
    );
  }
}
