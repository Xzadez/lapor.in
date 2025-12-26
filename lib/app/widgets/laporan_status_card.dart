import 'package:flutter/material.dart';

enum LaporanStatus {
  diterima,
  ditolak,
}

class LaporanStatusCard extends StatelessWidget {
  const LaporanStatusCard({
    super.key,
    required this.status,
  });

  final LaporanStatus status;

  @override
  Widget build(BuildContext context) {
    final isAccepted = status == LaporanStatus.diterima;

    final bgColor =
        isAccepted ? const Color(0xFF8EE3B7) : const Color(0xFFFF2D2D);

    final text =
        isAccepted ? 'Laporan berhasil diterima' : 'Laporan berhasil ditolak';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _icon(),
          const SizedBox(height: 12),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    return Container(
      height: 52,
      width: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: const Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}