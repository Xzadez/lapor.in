import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/form_laporan_controller.dart';

class FormLaporanScreen extends GetView<FormLaporanController> {
  const FormLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      // LAYOUT: COLUMN (Agar tombol fixed di bawah)
      body: Column(
        children: [
          // BAGIAN SCROLL (Form Input)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- NAMA ---
                  _buildLabel("Nama*"), // Hapus parameter hasAutosave
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: controller.namaC,
                    hint: "Nama Pelapor...",
                    readOnly: true,
                  ),

                  const SizedBox(height: 16),

                  // --- DESKRIPSI ---
                  _buildLabel("Deskripsi Laporan*"),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: controller.deskripsiC,
                    hint: "Deskripsi Laporan...",
                    minLines: 5,
                    maxLines: null, // Bisa memanjang
                    keyboardType: TextInputType.multiline,
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
                    onTap: () => controller.pickDate(context),
                  ),

                  const SizedBox(height: 16),

                  // --- KATEGORI ---
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

                  // --- FOTO ---
                  _buildLabel("Lampiran Foto*"), // Tambah bintang (*)
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: controller.pickImage,
                    child: Obx(() {
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
                                radius: 14,
                                child: Icon(
                                  Icons.close,
                                  size: 18,
                                  color: Colors.red,
                                ),
                              ),
                              onPressed:
                                  () => controller.selectedImage.value = null,
                            ),
                          ),
                        );
                      }

                      // Tampilan Default (KOSONG)
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
                            // Ubah teks ini biar jelas
                            Text(
                              "Upload Foto Bukti",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // BAGIAN TOMBOL (Fixed Bottom)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SizedBox(
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
                    elevation: 0,
                  ),
                  child:
                      controller.isLoading.value
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                            "Kirim",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Sederhana (Tanpa logika autosave UI)
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    int? maxLines = 1,
    int? minLines,
    TextInputType? keyboardType,
    IconData? icon,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
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
