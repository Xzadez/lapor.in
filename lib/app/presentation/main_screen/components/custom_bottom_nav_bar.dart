import 'package:flutter/material.dart';
import 'curve_painter.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Color navColor; // Tambahkan parameter warna
  final Function(int) onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.navColor, // Wajib diisi
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    const double contentHeight = 80.0;
    final double totalHeight = contentHeight + bottomPadding;

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
                  color: navColor, // Gunakan warna dari parameter
                ),
              );
            },
          ),

          // LAYER 2: Icons
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: contentHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
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
    final bool isSmallScreen = width < 360;
    final double activeSize = isSmallScreen ? 45 : 50;
    final double inactiveSize = isSmallScreen ? 26 : 30;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              margin: EdgeInsets.only(
                top: isSelected ? 0 : 25,
                bottom: isSelected ? 10 : 0,
              ),
              height: isSelected ? activeSize : inactiveSize,
              width: isSelected ? activeSize : inactiveSize,
              decoration: BoxDecoration(
                // Gunakan warna navColor untuk background icon aktif
                color: isSelected ? navColor : Colors.transparent,
                shape: BoxShape.circle,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
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
