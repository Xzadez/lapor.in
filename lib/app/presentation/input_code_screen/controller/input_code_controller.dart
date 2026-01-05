import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InputCodeController extends GetxController {
  final codeController = TextEditingController();
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  final supabase = Supabase.instance.client;

  void submitCode() async {
    final code = codeController.text.trim().toUpperCase();

    if (code.isEmpty) {
      errorMessage.value = "Kode undangan tidak boleh kosong";
      return;
    }

    errorMessage.value = "";
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final List<dynamic> invitationData = await supabase
          .from('community_invitations')
          .select('id, community_id, role, status, name')
          .eq('code', code);

      if (invitationData.isEmpty) {
        throw 'Kode undangan tidak ditemukan.';
      }

      final invitation = invitationData.first;
      final status = invitation['status'];

      if (status != 'pending') {
        throw 'Kode undangan ini sudah tidak berlaku lagi.';
      }

      final communityId = invitation['community_id'];
      final role = invitation['role'];
      final invitationId = invitation['id'];
      final invitedName = invitation['name'];
      final userId = supabase.auth.currentUser!.id;

      await supabase.from('profiles').update({
        'community_id': communityId,
        'role': role,
      }).eq('id', userId);

      await supabase.from('community_invitations').update({
        'status': 'accepted',
        'accepted_by': userId,
        'accepted_at': DateTime.now().toIso8601String(),
      }).eq('id', invitationId);

      final List<dynamic> communityNameData = await supabase
          .from('communities')
          .select('name')
          .eq('id', communityId);

      final communityName = communityNameData.isNotEmpty
          ? communityNameData.first['name']
          : 'Komunitas';

      Get.snackbar(
        "Berhasil",
        "Selamat datang, $invitedName! Anda telah bergabung dengan $communityName sebagai $role.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      final lowerCaseRole = role.toString().toLowerCase();
      final isPengurus = [
        'admin',
        'ketua',
        'ketua_rt',
        'ketua_rw',
        'sekretaris',
        'bendahara',
        'pengurus'
      ].contains(lowerCaseRole);

      if (isPengurus) {
        Get.offAllNamed(AppRoutes.pengurusBeranda);
      } else {
        Get.offAllNamed(AppRoutes.mainScreen);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        "Gagal",
        "Terjadi kesalahan: ${e.toString()}",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }
}
