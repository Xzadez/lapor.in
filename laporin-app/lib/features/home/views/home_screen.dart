import 'package:flutter/material.dart';
import '../controllers/home_controller.dart';

/// VIEW - HOME SCREEN
/// ---------------------------------------------------
/// Scrum Master : Rachmat Mauluddin
/// Dev Team     : Adriyan, Maulana Ziddan
/// ---------------------------------------------------

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _controller = HomeController();

  @override
  void initState() {
    super.initState();
    _controller.loadDashboardData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard Laporin")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Halo, User!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            // Kartu Statistik
            Row(
              children: [
                _buildStatCard("Total Laporan", _controller.totalLaporan, Colors.blue),
                const SizedBox(width: 10),
                _buildStatCard("Selesai", _controller.laporanSelesai, Colors.green),
              ],
            ),
            
            const SizedBox(height: 30),
            const Text("Menu Cepat", style: TextStyle(fontWeight: FontWeight.bold)),
            // Tambahkan tombol navigasi menu di sini...
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, ValueNotifier<int> valueNotifier, Color color) {
    return Expanded(
      child: Card(
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: valueNotifier,
                builder: (context, val, _) => Text("$val", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
              ),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}
