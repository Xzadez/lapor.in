import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../../../routes/app_routes.dart'; // Uncomment jika route generate code sudah ada
import '../model/add_member_model.dart'; // Import Model

class AddMemberController extends GetxController {
  // Text Controllers
  final firstNameC = TextEditingController();
  final lastNameC = TextEditingController();

  // Role Selection (Default 'warga')
  var selectedRole = 'warga'.obs;

  // Opsi Dropdown
  final List<Map<String, String>> roleOptions = [
    {'value': 'warga', 'label': 'Warga'},
    {'value': 'ketua_rt', 'label': 'Ketua RT'},
    {'value': 'ketua_rw', 'label': 'Ketua RW'},
  ];

  @override
  void onClose() {
    firstNameC.dispose();
    lastNameC.dispose();
    super.onClose();
  }

  void onTapNext() {
    // 1. Validasi
    if (firstNameC.text.trim().isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Nama depan wajib diisi",
        backgroundColor: Colors.amber.withOpacity(0.2),
      );
      return;
    }

    // 2. Buat Object Model
    final newMember = AddMemberModel(
      firstName: firstNameC.text.trim(),
      lastName: lastNameC.text.trim(),
      role: selectedRole.value,
    );

    // Debug print (Cek apakah model berfungsi)
    print(
      "Siap generate code untuk: ${newMember.fullName} sebagai ${newMember.displayRole}",
    );

    // 3. Kirim Model ke Halaman Selanjutnya (Generate Code)
    // Gunakan .toJson() agar mudah diterima di halaman sebelah

    // Get.toNamed(AppRoutes.generateCodeScreen, arguments: newMember.toJson());

    Get.snackbar(
      "Sukses",
      "Data ${newMember.fullName} siap diproses!",
      backgroundColor: Colors.green.withOpacity(0.1),
    );
  }
}
