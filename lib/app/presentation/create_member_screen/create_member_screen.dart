//import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/core/app_export.dart';
import 'package:laporin/app/presentation/create_member_screen/controller/create_member_controller.dart';

class CreateMemberScreen extends GetView<CreateMemberController> {
  const CreateMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Warna tema
    final Color primaryColor = const Color(0xFF1E88E5);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Background agak abu
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Buat Komunitas Baru",
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
            // --- HEADER INFO ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: primaryColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Anda akan didaftarkan sebagai Ketua Pengurus untuk komunitas ini.",
                      style: TextStyle(color: Colors.blue[900], fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              "Informasi Lingkungan",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // --- FORM INPUT ---
            _buildLabel("Nama Komunitas / Lingkungan"),
            _buildTextField(
              controller: controller.namaKomunitasC,
              hint: "Contoh: Warga RT 05 RW 02",
              icon: Icons.home_work_outlined,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("RT"),
                      _buildTextField(
                        controller: controller.rtC,
                        hint: "005",
                        isNumber: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel("RW"),
                      _buildTextField(
                        controller: controller.rwC,
                        hint: "002",
                        isNumber: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _buildLabel("Alamat Lengkap (Sekretariat/Pos)"),
            _buildTextField(
              controller: controller.alamatC,
              hint: "Jl. Mawar No. 12, Kel. Maju Jaya",
              icon: Icons.location_on_outlined,
              maxLines: 2,
            ),

            const SizedBox(height: 16),

            _buildLabel("Kota / Kabupaten"),
            _buildTextField(
              controller: controller.kotaC,
              hint: "Contoh: Jakarta Selatan",
              icon: Icons.location_city,
            ),

            const SizedBox(height: 40),

            // --- TOMBOL SUBMIT ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : () => controller.submitForm(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                  child:
                      controller.isLoading.value
                          ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : const Text(
                            "BUAT KOMUNITAS",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool isNumber = false,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
