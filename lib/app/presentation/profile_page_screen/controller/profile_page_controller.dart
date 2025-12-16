import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  final user = {
    'name': 'Ahmad Sentosa',
    'email': 'Ahmadsanzz@gmail.com',
  }.obs;

  void logout() {
    // Implement logout logic here
    print('Logout');
  }
}
