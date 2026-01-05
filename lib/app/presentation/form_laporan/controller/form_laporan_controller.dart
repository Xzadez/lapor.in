import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart'; // Import intl untuk format tanggal
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:laporin/app/widgets/custom_snackbar.dart'; // Gunakan snackbar overlay Anda

class FormLaporanController extends GetxController {
  final supabase = Supabase.instance.client;

  // Input Controllers
  final namaC = TextEditingController();
  final deskripsiC = TextEditingController();
  final tanggalC = TextEditingController(); // Untuk tampilan teks tanggal

  // Variables
  var selectedDate = DateTime.now().obs;
  var selectedCategory = 'Fasilitas'.obs;
  var selectedImage = Rx<File?>(null);
  var isLoading = false.obs;

  // Opsi Kategori
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
    // Set tanggal default hari ini
    tanggalC.text = DateFormat(
      'dd MMMM yyyy',
      'id_ID',
    ).format(selectedDate.value);
  }

  @override
  void onClose() {
    namaC.dispose();
    deskripsiC.dispose();
    tanggalC.dispose();
    super.onClose();
  }

  // 1. Auto Fill Nama (UX: Biar user gak ngetik nama sendiri)
  // 1. Auto Fill Nama (FIXED)
  void _autoFillUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      // UBAH SELECT: ambil first_name dan last_name, bukan 'name'
      final data =
          await supabase
              .from('profiles')
              .select('first_name, last_name')
              .eq('id', user.id)
              .single();

      if (data != null) {
        // Gabungkan First & Last Name
        String first = data['first_name'] ?? '';
        String last = data['last_name'] ?? '';

        // Isi ke TextField
        namaC.text = '$first $last'.trim();
      }
    }
  }

  // 2. Pilih Tanggal
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
      // Format tanggal Indonesia (Perlu setting locale di main.dart idealnya, tapi ini hardcode format dulu)
      tanggalC.text = DateFormat('dd MMMM yyyy').format(picked);
    }
  }

  // 3. Pilih Gambar (Galeri)
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

  // 4. Submit Laporan
  void submitLaporan() async {
    if (namaC.text.isEmpty || deskripsiC.text.isEmpty) {
      CustomSnackBar.show(
        message: "Mohon lengkapi semua data wajib *",
        isError: true,
      );
      return;
    }

    isLoading.value = true;

    try {
      final user = supabase.auth.currentUser;
      if (user == null) throw "User tidak terdeteksi";

      String? imageUrl;

      // A. Upload Foto jika ada
      if (selectedImage.value != null) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final path = 'laporan/$fileName';

        await supabase.storage
            .from('laporan_images')
            .upload(
              path,
              selectedImage.value!,
              fileOptions: const FileOptions(
                cacheControl: '3600',
                upsert: false,
              ),
            );

        // Dapatkan URL Publik
        imageUrl = supabase.storage.from('laporan_images').getPublicUrl(path);
      }

      // B. Insert Database
      await supabase.from('laporan').insert({
        'user_id': user.id,
        'nama_pelapor': namaC.text,
        'deskripsi': deskripsiC.text,
        'tanggal_kejadian': selectedDate.value.toIso8601String(),
        'kategori': selectedCategory.value,
        'foto_url': imageUrl,
        'status': 'menunggu',
      });

      CustomSnackBar.show(message: "Laporan berhasil dikirim!");
      Get.back(); // Kembali ke halaman sebelumnya
    } catch (e) {
      print(e);
      CustomSnackBar.show(message: "Gagal mengirim laporan: $e", isError: true);
    } finally {
      isLoading.value = false;
    }
  }
}
