import 'package:get/get.dart';
import 'package:laporin/app/presentation/join_member_screen/controller/join_member_controller.dart';

class JoinMemberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinMemberController>(() => JoinMemberController());
  }
}
