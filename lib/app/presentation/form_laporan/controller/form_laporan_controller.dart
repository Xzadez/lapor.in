import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart';

class FormLaporanController extends GetxController {
  final supabase = Supabase.instance.client;

  final namaC = TextEditingController();
  final deskripsiC = TextEditingController();
  final tanggalC = TextEditingController();

  var selectedDate = DateTime.now().obs;
  var selectedCategory = 'Fasilitas'.obs;
  var selectedImage = Rx<File?>(null);
  var isLoading = false.obs;

  final List<String> categories = [
    'Fasilitas',
    'Keamanan',
    'Kebersihan',
    'Sosial',
    'Lainnya',
  ];

  @override
  void onInit() {
    super.onInit();
    _autoFillUserData();
    _initDateText();
  }

  @override
  void onClose() {
    namaC.dispose();
    deskripsiC.dispose();
    tanggalC.dispose();
    super.onClose();
  }

  void _initDateText() {
    try {
      tanggalC.text = DateFormat(
        'dd MMMM yyyy',
        'id_ID',
      ).format(selectedDate.value);
    } catch (e) {
      tanggalC.text = DateFormat('dd MMMM yyyy').format(selectedDate.value);
    }
  }

  void _autoFillUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final data =
            await supabase
                .from('profiles')
                .select('first_name, last_name')
                .eq('id', user.id)
                .single();

        if (data != null) {
          String first = data['first_name'] ?? '';
          String last = data['last_name'] ?? '';
          namaC.text = '$first $last'.trim();
        }
      } catch (e) {
        print("Gagal ambil nama profile: $e");
      }
    }
  }

  void pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF35BBA4)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectedDate.value = picked;
      _initDateText();
    }
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  // LOGIC KIRIM (UPDATED)
  void submitLaporan() async {
    // 1. Validasi Input (Foto Wajib)
    if (namaC.text.isEmpty || deskripsiC.text.isEmpty) {
      CustomSnackBar.show(
        message: "Mohon lengkapi deskripsi laporan",
        isError: true,
      );
      return;
    }

    if (selectedImage.value == null) {
      CustomSnackBar.show(
        message: "Wajib menyertakan foto bukti!",
        isError: true,
      );
      return;
    }

    isLoading.value = true;

    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw "Sesi habis. Silakan login ulang.";

      String? imageUrl;

      // 2. Upload Foto
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = 'laporan/$fileName';

      await supabase.storage
          .from('laporan_images')
          .upload(
            path,
            selectedImage.value!,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      imageUrl = supabase.storage.from('laporan_images').getPublicUrl(path);

      // 3. INSERT DATABASE (Priority NULL)
      await supabase.from('laporan').insert({
        'user_id': user.id,
        'nama_pelapor': namaC.text,
        'deskripsi': deskripsiC.text,
        'tanggal_kejadian': selectedDate.value.toIso8601String(),
        'kategori': selectedCategory.value,
        'foto_url': imageUrl,
        'status': 'menunggu',
        'priority': null, // <--- EKSPLISIT NULL DI SINI
      });

      CustomSnackBar.show(message: "Laporan berhasil dikirim!");
      Get.back();
    } catch (e) {
      print(e);
      String errorMsg = e.toString();
      if (errorMsg.contains("SocketException"))
        errorMsg = "Periksa koneksi internet Anda";
      CustomSnackBar.show(message: "Gagal: $errorMsg", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
