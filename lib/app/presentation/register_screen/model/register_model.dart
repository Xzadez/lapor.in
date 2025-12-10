import 'package:get/get.dart';

class RegisterModel {
  Rx<String> firstName = Rx("");
  Rx<String> lastName = Rx("");
  Rx<DateTime?> birthDay = Rx(null);
  Rx<String> username = Rx("");
  Rx<String> email = Rx("");
  Rx<String> password = Rx("");
  Rx<String> repeatPassword = Rx("");
}
