import 'package:get/get.dart';
import 'package:laporin/app/presentation/create_member_screen/controller/create_member_controller.dart';

class CreateMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateMemberController>(() => CreateMemberController());
  }
}
