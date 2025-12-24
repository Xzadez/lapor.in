import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import '../model/add_member_model.dart';

class AddMemberController extends GetxController {
  // Ganti jadi Name Controller
  final nameC = TextEditingController();

  var selectedRole = 'warga'.obs;

  final List<Map<String, String>> roleOptions = [
    {'value': 'warga', 'label': 'Warga'},
    {'value': 'ketua_rt', 'label': 'Ketua RT'},
    {'value': 'ketua_rw', 'label': 'Ketua RW'},
  ];

  @override
  void onClose() {
    nameC.dispose();
    super.onClose();
  }

  void onTapNext() {
    // 1. Validasi Nama
    if (nameC.text.trim().isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Nama anggota wajib diisi",
        backgroundColor: Colors.amber.withOpacity(0.2),
      );
      return;
    }

    // 2. Buat Model dengan Nama
    final newMember = AddMemberModel(
      name: nameC.text.trim(),
      role: selectedRole.value,
    );

    // 3. Kirim ke Halaman Selanjutnya
    Get.toNamed(AppRoutes.generateCode, arguments: newMember.toJson());

    // Reset Form
    nameC.clear();
    selectedRole.value = 'warga';
  }
}
