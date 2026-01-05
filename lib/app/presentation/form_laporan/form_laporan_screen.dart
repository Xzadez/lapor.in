import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/form_laporan_controller.dart';

class FormLaporanScreen extends GetView<FormLaporanController> {
  const FormLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna tema sesuai request (Tosca)
    final Color themeColor = const Color(0xFF35BBA4);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Tambah Laporan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- NAMA PELAPOR ---
            _buildLabel("Nama*", hasAutosave: true),
            const SizedBox(height: 8),
            _buildTextField(
              controller: controller.namaC,
              hint: "Nama Pelapor...",
              readOnly: true,
            ),

            const SizedBox(height: 16),

            // --- DESKRIPSI LAPORAN ---
            _buildLabel("Deskripsi Laporan*"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: controller.deskripsiC,
              hint: "Deskripsi Laporan...",
              maxLines: 5, // Kotak lebih besar
            ),

            const SizedBox(height: 16),

            // --- TANGGAL ---
            _buildLabel("Tanggal*"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: controller.tanggalC,
              hint: "Pilih Tanggal",
              icon: Icons.calendar_today_outlined,
              readOnly: true,
            ),

            const SizedBox(height: 16),

            // --- KATEGORI LAPORAN (DROPDOWN) ---
            _buildLabel("Kategori Laporan*"),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Obx(
                () => DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedCategory.value,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items:
                        controller.categories.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null)
                        controller.selectedCategory.value = newValue;
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // --- LAMPIRAN FOTO ---
            _buildLabel("Lampiran Foto*"),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: controller.pickImage,
              child: Obx(() {
                // Tampilan jika gambar sudah dipilih
                if (controller.selectedImage.value != null) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade400),
                      image: DecorationImage(
                        image: FileImage(controller.selectedImage.value!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.close, size: 20, color: Colors.red),
                        ),
                        onPressed: () => controller.selectedImage.value = null,
                      ),
                    ),
                  );
                }

                // Tampilan default (Belum ada gambar)
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "foto.jpg/.png",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Icon(Icons.attach_file, color: Colors.black54),
                    ],
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // --- TOMBOL SIMPAN ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : controller.submitLaporan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget Helper untuk Label
  Widget _buildLabel(String text, {bool hasAutosave = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        if (hasAutosave)
          Row(
            children: const [
              Text(
                "Autosave ",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Icon(Icons.check, size: 14, color: Colors.grey),
            ],
          ),
      ],
    );
  }

  // Widget Helper untuk TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    IconData? icon,
    bool readOnly = false, // Tambah parameter ini
    VoidCallback? onTap, // Tambah parameter ini
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly, // Set status disable ketik
      onTap: onTap, // Set aksi klik
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        suffixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF35BBA4), width: 1.5),
        ),
      ),
    );
  }
}
