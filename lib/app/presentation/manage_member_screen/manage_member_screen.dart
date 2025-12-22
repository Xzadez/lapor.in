import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/manage_member_controller.dart';
import 'model/manage_member_model.dart';

class ManageMemberScreen extends GetView<ManageMemberController> {
  const ManageMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color themeColor = const Color(0xFF35BBA4);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Data Anggota",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onTapAddMember,
        backgroundColor: themeColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: themeColor));
        }

        if (controller.memberList.isEmpty) {
          return const Center(child: Text("Belum ada data anggota"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.memberList.length,
          itemBuilder: (context, index) {
            final ManageMemberModel member = controller.memberList[index];
            return _buildMemberCard(member, themeColor);
          },
        );
      }),
    );
  }

  Widget _buildMemberCard(ManageMemberModel data, Color color) {
    // 1. Cek Warna Badge
    bool isWarga = data.role.toLowerCase() == 'warga';
    Color roleColor = isWarga ? Colors.grey : color;

    // 2. Cek Apakah Ini Kartu Milik Sendiri?
    bool isMe = data.id == controller.currentUserId;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: roleColor.withOpacity(0.1),
            child: Text(
              data.fullName.isNotEmpty ? data.fullName[0].toUpperCase() : '?',
              style: TextStyle(
                color: roleColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        data.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Optional: Kasih label "(Anda)" jika itu diri sendiri
                    if (isMe)
                      Text(
                        " (Anda)",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: isWarga ? Colors.grey[200] : Colors.green[50],
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color:
                          isWarga
                              ? Colors.grey.shade300
                              : Colors.green.shade200,
                    ),
                  ),
                  child: Text(
                    data.displayRole,
                    style: TextStyle(
                      fontSize: 10,
                      color: isWarga ? Colors.grey[700] : Colors.green[800],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (!isMe)
            IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onPressed: () {
                // Aksi Edit/Hapus User Lain
              },
            ),
        ],
      ),
    );
  }
}
