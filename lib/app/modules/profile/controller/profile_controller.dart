import 'package:get/get.dart';

class ProfileController extends GetxController {
  var user = {
    'name': 'Ahmad Sentosa',
    'email': 'Ahmadsanzz@gmail.com',
    'photoUrl': null,
  }.obs;

  void logout() {
    Get.snackbar(
      'Logout',
      'Kamu telah keluar.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
