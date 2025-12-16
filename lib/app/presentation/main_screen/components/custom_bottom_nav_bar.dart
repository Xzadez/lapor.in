import 'package:flutter/material.dart';
import 'curve_painter.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Mendapatkan tinggi area aman bawah (poni bawah/home indicator)
    final double bottomPadding = MediaQuery.of(context).padding.bottom;

    // Tinggi konten utama navbar (tanpa safe area)
    const double contentHeight = 80.0;

    // Tinggi total = tinggi konten + safe area
    final double totalHeight = contentHeight + bottomPadding;

    const Color navColor = Color(0xFF1E88E5);

    return SizedBox(
      height: totalHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // LAYER 1: Background Curve
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: selectedIndex.toDouble()),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutQuad,
            builder: (context, value, child) {
              return CustomPaint(
                size: Size(size.width, totalHeight),
                painter: CurvePainter(
                  position: value,
                  itemsCount: 4,
                  color: navColor,
                ),
              );
            },
          ),

          // LAYER 2: Icons
          // Kita batasi tinggi area icon hanya setinggi contentHeight (80)
          // agar icon tidak turun ke area safe padding (garis bawah HP)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: contentHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Pastikan center vertikal
              children: [
                _buildNavItem(context, Icons.home, "Beranda", 0),
                _buildNavItem(context, Icons.assignment_outlined, "Laporan", 1),
                _buildNavItem(context, Icons.history, "Riwayat", 2),
                _buildNavItem(context, Icons.person, "Profile", 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final bool isSelected = selectedIndex == index;
    final double width = MediaQuery.of(context).size.width;

    // Responsif: Sesuaikan ukuran icon berdasarkan lebar layar
    // Jika layar kecil (seperti iPhone SE), kurangi sedikit ukurannya
    final bool isSmallScreen = width < 360;
    final double activeSize = isSmallScreen ? 45 : 50;
    final double inactiveSize = isSmallScreen ? 26 : 30;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 65, // Lebar area sentuh per item
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.start, // Mulai dari atas container
          mainAxisSize:
              MainAxisSize.min, // Penting untuk mencegah overflow vertikal
          children: [
            // Spacer dinamis untuk icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: EdgeInsets.only(
                // Logic Margin:
                // Jika aktif: margin atas 0 (naik ke lengkungan), bawah agak besar
                // Jika tidak aktif: margin atas 25 (turun ke tengah), bawah 0
                top: isSelected ? 0 : 25,
                bottom: isSelected ? 10 : 0,
              ),
              height: isSelected ? activeSize : inactiveSize,
              width: isSelected ? activeSize : inactiveSize,
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xFF1E88E5) : Colors.transparent,
                shape: BoxShape.circle,
                // Shadow hanya untuk yang aktif
                boxShadow:
                    isSelected
                        ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                        : null,
                border:
                    isSelected
                        ? Border.all(color: Colors.white, width: 2)
                        : null,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: isSelected ? (activeSize * 0.55) : (inactiveSize * 0.8),
              ),
            ),

            Flexible(
              // Gunakan Flexible agar teks bisa mengecil jika ruang sempit
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: FittedBox(
                  // Mencegah teks overflow ke samping/bawah
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10, // Ukuran font dasar
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
