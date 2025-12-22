import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/create_member_screen/model/create_member_model.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreateMemberController extends GetxController {
  // Input Controllers
  final namaKomunitasC = TextEditingController();
  final rtC = TextEditingController();
  final rwC = TextEditingController();
  final alamatC = TextEditingController();
  final kotaC = TextEditingController();

  final isLoading = false.obs;
  final supabase = Supabase.instance.client;

  @override
  void onClose() {
    namaKomunitasC.dispose();
    rtC.dispose();
    rwC.dispose();
    alamatC.dispose();
    kotaC.dispose();
    super.onClose();
  }

  void submitForm() async {
    // 1. Validasi Sederhana
    if (namaKomunitasC.text.isEmpty || rtC.text.isEmpty || rwC.text.isEmpty) {
      CustomSnackBar.show(
        message: "Error: Mohon lengkapi data wajib (Nama, RT, RW)",
        isError: true,
      );
      return;
    }

    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw "Sesi habis. Silahkan login ulang.";

      final newCommunity = CommunityModel(
        name: namaKomunitasC.text,
        rt: rtC.text,
        rw: rwC.text,
        address: alamatC.text,
        city: kotaC.text,
        createdBy: user.id,
      );

      final response =
          await supabase
              .from('communities')
              .insert(newCommunity.toJson())
              .select()
              .single();

      final String communityId = response['id'];

      await supabase
          .from('profiles')
          .update({'role': 'admin', 'community_id': communityId})
          .eq('id', user.id);

      CustomSnackBar.show(
        message: "Komunitas ${namaKomunitasC.text} berhasil dibuat!",
        isError: false,
      );
      Get.offAllNamed(AppRoutes.mainScreen);
    } catch (e) {
      CustomSnackBar.show(
        message: "Gagal, Terjadi kesalahan: $e",
        isError: true,
      );
      debugPrint('Terjadi Kesalahan Debug: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
