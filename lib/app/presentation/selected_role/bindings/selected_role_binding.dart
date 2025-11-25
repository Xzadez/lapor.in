import 'package:get/get.dart';

import '../controllers/selected_role_controller.dart';

class SelectedRoleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedRoleController>(
      () => SelectedRoleController(),
    );
  }
}
