import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/laporan_screen/model/laporan_model.dart';
import '../laporan_screen/controller/laporan_controller.dart';

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject Controller
    final controller = Get.put(LaporanController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.fetchLaporan, // Fitur Tarik untuk Refresh
          color: const Color(0xFF35BBA4),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 16),

                // --- LIST LAPORAN (REACTIVE) ---
                Obx(() {
                  // 1. Loading State
                  if (controller.isLoading.value) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: CircularProgressIndicator(
                          color: Color(0xFF35BBA4),
                        ),
                      ),
                    );
                  }

                  // 2. Empty State (Kosong)
                  if (controller.laporanList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Column(
                          children: [
                            Icon(
                              Icons.assignment_outlined,
                              size: 60,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Belum ada laporan",
                              style: TextStyle(color: Colors.grey[500]),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // 3. List Data
                  return Column(
                    children:
                        controller.laporanList
                            .map(
                              (laporan) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _buildLaporanCard(laporan, controller),
                              ),
                            )
                            .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader() {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          // Logo atau Ikon (Sesuaikan jika ada asset)
          // Image.asset('assets/images/logo.png', height: 32),
          const Text(
            'Laporan Saya',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          // Ikon Sortir (Opsional)
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implementasi Sortir (Terbaru/Terlama)
            },
          ),
        ],
      ),
    );
  }

  // ================= KARTU LAPORAN =================
  Widget _buildLaporanCard(LaporanModel data, LaporanController controller) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- BARIS ATAS (TANGGAL & STATUS) ---
          Row(
            children: [
              Text(
                data.tanggal,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
              const Spacer(),

              // LOGIKA STATUS TEXT (KANAN ATAS)
              if (data.rejected)
                const Text(
                  "Ditolak",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else if (data.cancelled) // <--- STATUS DIBATALKAN
                const Text(
                  "Dibatalkan",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                )
              else if (data.estimasi != null) // <--- STATUS ESTIMASI
                Text(
                  data.estimasi!,
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                ),

              const SizedBox(width: 4),

              // --- POPUP MENU (TITIK TIGA) ---
              // Hanya muncul jika laporan BELUM dibatalkan/ditolak
              if (!data.cancelled && !data.rejected)
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 18,
                    color: Colors.grey,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onSelected: (String value) {
                    if (value == 'edit') {
                      controller.editLaporan(data);
                    } else if (value == 'delete') {
                      // Panggil fungsi soft delete / batalkan
                      controller.deleteLaporan(data.id, data.imageUrl);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    // Logic: Edit hanya bisa jika status masih 'Menunggu' (0)
                    bool isEditable = (data.statusIndex == 0);

                    return [
                      if (isEditable)
                        const PopupMenuItem<String>(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 16, color: Colors.blue),
                              SizedBox(width: 8),
                              Text('Ubah', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                        ),
                      // Menu Hapus (Sebenarnya Membatalkan)
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, size: 16, color: Colors.red),
                            SizedBox(width: 8),
                            Text(
                              'Batalkan Laporan',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
            ],
          ),

          const SizedBox(height: 6),

          // --- JUDUL / DESKRIPSI ---
          Text(
            data.judul,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 8),

          // --- BADGES (KATEGORI & URGENT) ---
          Row(
            children: [
              if (data.urgent) ...[
                _buildBadge("Urgent", Colors.red),
                const SizedBox(width: 8),
              ],
              _buildBadge(data.kategori, const Color(0xFF35BBA4)),
            ],
          ),

          const SizedBox(height: 12),

          // --- GAMBAR FOTO ---
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              data.imageUrl,
              height: 110,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Container(
                    height: 110,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
            ),
          ),

          const SizedBox(height: 14),

          // --- PROGRESS BAR ---
          _buildStepProgress(
            data.statusIndex,
            isCancelled: data.cancelled,
            isRejected: data.rejected,
          ),
        ],
      ),
    );
  }

  // ================= BADGE HELPER =================
  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ================= PROGRESS BAR HELPER =================
  Widget _buildStepProgress(
    int activeIndex, {
    bool isCancelled = false,
    bool isRejected = false,
  }) {
    final steps = ["Dibatalkan", "Diajukan", "Diterima", "Diproses", "Selesai"];

    // Jika dibatalkan/ditolak, progress bar kita buat abu-abu semua atau merah
    Color activeColor = const Color(0xFF35BBA4);
    if (isRejected) activeColor = Colors.red;
    if (isCancelled) activeColor = Colors.grey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (i) {
        // --- LOGIKA BARU ---
        bool isActive = false;
        bool isCurrent = (i == activeIndex);

        if (isCancelled) {
          // Jika BATAL: Hanya Step 0 (Dibatalkan) yang aktif
          if (i == 0) isActive = true;
        } else {
          // Jika NORMAL: Step 0 (Dibatalkan) HARUS MATI.
          // Step 1 ke atas nyala sesuai progres.
          if (i == 0) {
            isActive = false;
          } else {
            if (i <= activeIndex) isActive = true;
          }
        }
        // -------------------

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  // Garis Kiri
                  Expanded(
                    child: Container(
                      height: 2,
                      // Hapus garis sebelum step pertama
                      color:
                          i == 0
                              ? Colors.transparent
                              : (isActive ? activeColor : Colors.grey[300]),
                    ),
                  ),

                  // Lingkaran Indikator
                  Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: isActive ? activeColor : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isActive ? activeColor : Colors.grey[300]!,
                      ),
                    ),
                    child:
                        isCurrent
                            ? const Center(
                              child: Icon(
                                Icons.circle,
                                size: 6,
                                color: Colors.white,
                              ),
                            )
                            : null,
                  ),

                  // Garis Kanan
                  Expanded(
                    child: Container(
                      height: 2,
                      // Hapus garis setelah step terakhir
                      color:
                          i == steps.length - 1
                              ? Colors.transparent
                              // Khusus Normal Flow: Garis setelah Step 0 (Dibatalkan) jangan nyala
                              // agar terlihat lompat langsung ke Step 1 (Diajukan)
                              : ((!isCancelled && i == 0)
                                  ? Colors.grey[300]
                                  : (i < activeIndex
                                      ? activeColor
                                      : Colors.grey[300])),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              // Teks Label
              Text(
                steps[i],
                style: TextStyle(
                  fontSize: 9, // Perkecil sedikit biar muat 5 text
                  color: isActive ? Colors.black87 : Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }),
    );
  }
}
