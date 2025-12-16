import 'package:flutter/material.dart';
import '../models/user_profile_model.dart';

/// VIEW - PROFILE PAGE
/// ---------------------------------------------------
/// Product Owner : Satria
/// Scrum Master  : Rafly
/// Dev Team      : Adriyan, Rafly
/// ---------------------------------------------------

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulasi data user yang sudah di-load
    final user = UserProfileModel(
      nama: "Maulana Ziddan", 
      email: "ziddan@example.com", 
      noHp: "08123456789"
    );

    return Scaffold(
      appBar: AppBar(title: const Text("Profil Saya")),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            const SizedBox(height: 20),
            Text(user.nama, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(user.email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Keluar Akun", style: TextStyle(color: Colors.red)),
              onTap: () {
                // Logic logout disini
              },
            )
          ],
        ),
      ),
    );
  }
}
