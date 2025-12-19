import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/controller.dart';

class TambahLaporanScreen
    extends GetView<TambahLaporanController> {
  const TambahLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: const [
                    _FormCard(),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _SubmitButton(),
    );
  }
}
class _Header extends GetView<TambahLaporanController> {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: controller.back,
            icon: const Icon(Icons.arrow_back),
          ),
          const Expanded(
            child: Text(
              'Tambah Laporan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: const [
              Text(
                'Autosave',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
              SizedBox(width: 4),
              Icon(Icons.check_circle,
                  color: Colors.green, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}
class _FormCard extends GetView<TambahLaporanController> {
  const _FormCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _Input(
              label: 'Nama*',
              hint: 'Nama Pelapor...',
              onChanged: (v) => controller.nama.value = v,
            ),
            const SizedBox(height: 16),
            _Input(
              label: 'Deskripsi Laporan*',
              hint: 'Deskripsi Laporan...',
              maxLines: 5,
              onChanged: (v) => controller.deskripsi.value = v,
            ),
            const SizedBox(height: 16),
            _DatePicker(),
            const SizedBox(height: 16),
            _DropdownKategori(),
            const SizedBox(height: 16),
            _UploadField(),
          ],
        ),
      ),
    );
  }
}
class _Input extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final ValueChanged<String> onChanged;

  const _Input({
    required this.label,
    required this.hint,
    required this.onChanged,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF2EC4B6),
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _DatePicker extends GetView<TambahLaporanController> {
  const _DatePicker();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tanggal*',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          InkWell(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: controller.tanggal.value,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) controller.setTanggal(picked);
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F8FA),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    '${controller.tanggal.value.day} '
                        '${controller.tanggal.value.month} '
                        '${controller.tanggal.value.year}',
                  ),
                  const Spacer(),
                  const Icon(Icons.calendar_today, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _DropdownKategori
    extends GetView<TambahLaporanController> {
  const _DropdownKategori();

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kategori Laporan*',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: controller.kategori.value,
            items: controller.kategoriList
                .map(
                  (e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ),
            )
                .toList(),
            onChanged: (v) => controller.kategori.value = v!,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF7F8FA),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _UploadField extends StatelessWidget {
  const _UploadField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Lampiran Foto',
            style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8FA),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: const [
              Expanded(child: Text('foto.jpg / png')),
              Icon(Icons.attach_file),
            ],
          ),
        ),
      ],
    );
  }
}
class _SubmitButton
    extends GetView<TambahLaporanController> {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 46,
        child: ElevatedButton(
          onPressed: controller.simpan,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2EC4B6),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: const Text(
            'Simpan',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
