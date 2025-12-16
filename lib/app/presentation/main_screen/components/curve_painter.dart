import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  final double position; // Posisi kurva (0.0 sampai 1.0)
  final int itemsCount; // Jumlah menu (misal 4)
  final Color color; // Warna navbar (Biru)

  CurvePainter({
    required this.position,
    required this.itemsCount,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    Path path = Path();

    // Lebar satu item
    double itemWidth = size.width / itemsCount;

    // Titik tengah lengkungan saat ini (berdasarkan animasi position)
    double currentCenter = (itemWidth * position) + (itemWidth / 2);

    // Konfigurasi Lebar dan Kedalaman Lengkungan
    double curveWidth = 70; // Seberapa lebar "mulut" lengkungan
    double curveDepth = 45; // Seberapa dalam lengkungan ke bawah
    double topHeight = 15; // Tinggi navbar dari garis paling atas

    // --- Mulai Menggambar ---

    // 1. Titik Kiri Atas
    path.moveTo(0, topHeight);

    // 2. Garis lurus sampai sebelum lengkungan
    path.lineTo(currentCenter - curveWidth, topHeight);

    // 3. Membuat Lengkungan (Mangkok)
    path.cubicTo(
      currentCenter - (curveWidth * 0.5),
      topHeight, // Control point kiri atas
      currentCenter - (curveWidth * 0.5),
      topHeight + curveDepth, // Control point kiri bawah
      currentCenter,
      topHeight + curveDepth, // Titik tengah bawah (Puncak kedalaman)
    );

    path.cubicTo(
      currentCenter + (curveWidth * 0.5),
      topHeight + curveDepth, // Control point kanan bawah
      currentCenter + (curveWidth * 0.5),
      topHeight, // Control point kanan atas
      currentCenter + curveWidth,
      topHeight, // Titik akhir lengkungan (kembali ke datar)
    );

    // 4. Garis lurus sisa ke kanan
    path.lineTo(size.width, topHeight);

    // 5. Tutup ke bawah dan kiri
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    // Gambar bayangan halus (opsional)
    canvas.drawShadow(path, Colors.black.withOpacity(0.15), 4.0, true);

    // Gambar path utama
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CurvePainter oldDelegate) {
    return oldDelegate.position != position;
  }
}
