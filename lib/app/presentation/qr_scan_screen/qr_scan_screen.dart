import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'controller/qr_scan_controller.dart';

class QrScanScreen extends GetView<QrScanController> {
  const QrScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. KAMERA VIEW
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.onDetect,
            overlayBuilder: (context, constraints) {
              return Container(
                decoration: ShapeDecoration(
                  shape: QrScannerOverlayShape(
                    borderColor: const Color(0xFF1E88E5), // Warna Biru Laporin
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 300, // Ukuran kotak scan
                  ),
                ),
              );
            },
          ),

          // 2. HEADER: TOMBOL BACK & JUDUL
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(
                    icon: Icons.arrow_back,
                    onTap: () => Get.back(),
                  ),
                  const Text(
                    "Pindai QR Code",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                    ),
                  ),
                  _circleButton(
                    icon: Icons.flash_on,
                    onTap: controller.toggleTorch,
                  ),
                ],
              ),
            ),
          ),

          // 3. TEKS PETUNJUK DI BAWAH
          const Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Text(
              "Arahkan kamera ke kode QR Instansi\nPastikan cahaya cukup terang",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Tombol Bulat Transparan
  Widget _circleButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black45,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

// Custom Shape Painter untuk Overlay Gelap (Efek Bolong di Tengah)
class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderWidth = 10.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 80), // Hitam Transparan
    this.borderRadius = 10,
    this.borderLength = 40,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => const EdgeInsets.all(10);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: rect.center,
          width: cutOutSize,
          height: cutOutSize,
        ),
        Radius.circular(borderRadius),
      ),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path path = Path()..addRect(rect);
    return path; // Simple rect
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Gambar Overlay Gelap
    final width = rect.width;
    final height = rect.height;
    final backgroundPaint =
        Paint()
          ..color = overlayColor
          ..style = PaintingStyle.fill;

    final cutOutRect = Rect.fromCenter(
      center: rect.center,
      width: cutOutSize,
      height: cutOutSize,
    );

    final cutOutPath =
        Path()..addRRect(
          RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)),
        );

    // Teknik "Difference": Gambar kotak penuh dikurangi kotak tengah
    canvas.drawPath(
      Path.combine(PathOperation.difference, Path()..addRect(rect), cutOutPath),
      backgroundPaint,
    );

    // Gambar Border Sudut (Pojokan)
    final borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(
      cutOutRect.left - borderOffset,
      cutOutRect.top - borderOffset,
      cutOutRect.right + borderOffset,
      cutOutRect.bottom + borderOffset,
    );

    // Gambar 4 Sudut
    // Kiri Atas
    canvas.drawPath(
      Path()
        ..moveTo(realReact.left, realReact.top + borderLength)
        ..lineTo(realReact.left, realReact.top)
        ..lineTo(realReact.left + borderLength, realReact.top),
      borderPaint,
    );
    // Kanan Atas
    canvas.drawPath(
      Path()
        ..moveTo(realReact.right, realReact.top + borderLength)
        ..lineTo(realReact.right, realReact.top)
        ..lineTo(realReact.right - borderLength, realReact.top),
      borderPaint,
    );
    // Kanan Bawah
    canvas.drawPath(
      Path()
        ..moveTo(realReact.right, realReact.bottom - borderLength)
        ..lineTo(realReact.right, realReact.bottom)
        ..lineTo(realReact.right - borderLength, realReact.bottom),
      borderPaint,
    );
    // Kiri Bawah
    canvas.drawPath(
      Path()
        ..moveTo(realReact.left, realReact.bottom - borderLength)
        ..lineTo(realReact.left, realReact.bottom)
        ..lineTo(realReact.left + borderLength, realReact.bottom),
      borderPaint,
    );
  }

  @override
  ShapeBorder scale(double t) => this;
}
