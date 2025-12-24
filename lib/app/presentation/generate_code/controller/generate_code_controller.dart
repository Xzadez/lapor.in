import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../add_member_screen/model/add_member_model.dart';
import '../model/invitation_model.dart'; // IMPORT MODEL BARU

class GenerateCodeController extends GetxController {
  final supabase = Supabase.instance.client;

  var isLoading = false.obs;
  var generatedCode = ''.obs;

  late AddMemberModel candidateData;

  final ScreenshotController screenshotController = ScreenshotController();
  var isSharing = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      // Kita terima Map, lalu convert balik ke Model
      candidateData = AddMemberModel.fromJson(Get.arguments);
    } else {
      Get.back();
    }
  }

  void generateInvitation() async {
    isLoading.value = true;
    try {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      // 1. Ambil ID Komunitas
      final profileData =
          await supabase
              .from('profiles')
              .select('community_id')
              .eq('id', user.id)
              .single();

      final String? communityId = profileData['community_id'];

      if (communityId == null) {
        CustomSnackBar.show(
          message: "Error: Anda belum terdaftar dalam komunitas",
          isError: true,
        );
        return;
      }

      // 2. Buat Kode Unik
      final String newCode = _generateRandomCode(6);

      // 3. BUAT OBJECT MODEL (INVITATION)
      final newInvitation = InvitationModel(
        code: newCode,
        name: candidateData.name,
        role: candidateData.role,
        communityId: communityId,
        createdBy: user.id,
        status: 'pending',
        expiresAt: DateTime.now().add(const Duration(hours: 24)),
      );

      // 4. SIMPAN KE DB MENGGUNAKAN .toJson()
      await supabase
          .from('community_invitations')
          .insert(newInvitation.toJson()); // Lebih rapi dan type-safe

      // 5. Update UI
      generatedCode.value = newCode;

      CustomSnackBar.show(
        message: "Berhasil: Kode undangan berhasil dibuat!",
        isError: false,
      );
    } catch (e) {
      CustomSnackBar.show(
        message: "Gagal, Terjadi kesalahan saat membuat kode",
        isError: true,
      );
      print("Error generate code: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String _generateRandomCode(int length) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  void copyToClipboard() {
    if (generatedCode.value.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: generatedCode.value));
      CustomSnackBar.show(
        message: "Disalin, Kode berhasil disalin ke clipboard",
        isError: false,
      );
    }
  }

  Future<void> shareQrCode() async {
    if (generatedCode.value.isEmpty) return;

    isSharing.value = true;
    try {
      // 1. Capture widget yang dibungkus Screenshot()
      final Uint8List? imageBytes = await screenshotController.capture();

      if (imageBytes != null) {
        // 2. Dapatkan direktori temporary di HP
        try {
          // Cek akses & Simpan
          // Gal akan otomatis meminta izin jika belum ada
          await Gal.putImageBytes(imageBytes);

          CustomSnackBar.show(
            message: "Tersimpan: QR Code berhasil disimpan ke Galeri",
            isError: false,
          );
        } catch (e) {
          // Jika user menolak izin galeri, kita tetap lanjut share (jangan stop)
          print("Gagal save ke galeri (mungkin izin ditolak): $e");
        }
        // --------------------------------------

        // 2. Proses Share (Lanjut Share ke WA/Sosmed)
        final directory = await getTemporaryDirectory();
        final imagePath =
            await File(
              '${directory.path}/undangan-${generatedCode.value}.png',
            ).create();
        await imagePath.writeAsBytes(imageBytes);

        await Share.shareXFiles(
          [XFile(imagePath.path)],
          text:
              'Halo ${candidateData.name}, ini kode undangan untuk bergabung: ${generatedCode.value}',
        );
      }
    } catch (e) {
      print("Error sharing QR: $e");
      CustomSnackBar.show(
        message: "Gagal: Terjadi kesalahan saat memproses gambar",
        isError: true,
      );
    } finally {
      isSharing.value = false;
    }
  }
}
