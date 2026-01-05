import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InputCodeController extends GetxController {
  final supabase = Supabase.instance.client;

  // Controller untuk TextField
  final codeC = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onClose() {
    codeC.dispose();
    super.onClose();
  }

  Future<void> submitCode() async {
    // Pastikan Huruf Besar & Trim
    String codeInput = codeC.text.trim().toUpperCase();

    // 1. Validasi Input Kosong
    if (codeInput.isEmpty) {
      Get.snackbar(
        "Peringatan",
        "Kode undangan tidak boleh kosong",
        backgroundColor: Colors.amber.withOpacity(0.2),
        margin: EdgeInsets.all(10),
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;
    errorMessage.value = "";
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      final currentUser = supabase.auth.currentUser;
      if (currentUser == null) throw "Sesi habis, silakan login ulang.";

      // 2. CEK KODE DI DATABASE
      final invitationData =
          await supabase
              .from('community_invitations')
              .select('id, community_id, role, status, name, expires_at')
              .eq('code', codeInput)
              .maybeSingle();

      // 3. Validasi Ketersediaan Kode
      if (invitationData == null) {
        throw "Kode undangan tidak ditemukan.";
      }

      // 4. Validasi Status
      if (invitationData['status'] != 'pending') {
        throw "Kode undangan ini sudah terpakai atau tidak berlaku.";
      }

      // 5. Validasi Kadaluarsa
      if (invitationData['expires_at'] != null) {
        final DateTime expiresAt = DateTime.parse(invitationData['expires_at']);
        // Gunakan .toUtc() jika perlu, atau default local
        if (DateTime.now().isAfter(expiresAt)) {
          throw "Kode undangan sudah kadaluarsa.";
        }
      }

      // --- JIKA SEMUA VALID ---

      final communityId = invitationData['community_id'];
      final role = invitationData['role'];
      final invitationId = invitationData['id'];
      final invitedName = invitationData['name'];

      // A. Update Profile User (Masukkan ke komunitas & Update Role)
      await supabase
          .from('profiles')
          .update({
            'community_id': communityId,
            'role':
                role, // Role otomatis terupdate (jadi ketua_rt/rw atau warga)
          })
          .eq('id', currentUser.id);

      // B. Tandai Undangan sebagai 'accepted'
      await supabase
          .from('community_invitations')
          .update({
            'status': 'accepted',
            'accepted_by': currentUser.id,
            'accepted_at': DateTime.now().toIso8601String(),
          })
          .eq('id', invitationId);

      // C. Ambil Nama Komunitas (Optional)
      final List<dynamic> communityNameData = await supabase
          .from('communities')
          .select('name')
          .eq('id', communityId);
      final communityName =
          communityNameData.isNotEmpty
              ? communityNameData.first['name']
              : 'Komunitas';

      // D. Notifikasi Sukses
      Get.snackbar(
        "Berhasil",
        "Selamat datang, $invitedName! Anda bergabung dengan $communityName sebagai $role.",
        backgroundColor: Colors.green.withOpacity(0.1),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );

      // E. ROUTING (LANGSUNG KE MAIN SCREEN)
      // Karena MainScreen sudah dinamis (bisa berubah warna/menu berdasarkan role),
      // kita tidak perlu membedakan route lagi di sini.
      Get.offAllNamed(AppRoutes.mainScreen);
    } catch (e) {
      errorMessage.value = e.toString().replaceAll("Exception: ", "");
      Get.snackbar(
        "Gagal",
        errorMessage.value,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
