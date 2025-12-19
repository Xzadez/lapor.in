import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/respon_laporan_controller.dart';

class ResponLaporanScreen
    extends GetView<ResponLaporanController> {
  const ResponLaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const _Header(),
            const SizedBox(height: 12),
            const _ProgressCard(),
            const SizedBox(height: 12),
            const Expanded(child: _ChatSection()),
            const _InputSection(),
          ],
        ),
      ),
    );
  }
}
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          const Expanded(
            child: Text(
              'Respon Laporan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
class _ProgressCard extends GetView<ResponLaporanController> {
  const _ProgressCard();

  static const _steps = [
    'Diajukan',
    'Diterima',
    'Diproses',
    'Selesai',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
              () {
            final activeIndex = controller.progressIndex;

            return Column(
              children: [
                Row(
                  children: List.generate(_steps.length, (index) {
                    final isActive = index <= activeIndex;

                    return Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _Circle(isActive),
                              if (index != _steps.length - 1)
                                Expanded(
                                  child: Container(
                                    height: 4,
                                    color: index < activeIndex
                                        ? Colors.green
                                        : Colors.grey.shade300,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _steps[index],
                            style: TextStyle(
                              fontSize: 11,
                              color: isActive
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),

                // ---- DEMO BUTTON (hapus nanti kalau pakai API)
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: LaporanProgress.values.map((e) {
                    return OutlinedButton(
                      onPressed: () => controller.setProgress(e),
                      child: Text(e.name),
                    );
                  }).toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Circle extends StatelessWidget {
  final bool active;
  const _Circle(this.active);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? Colors.green : Colors.grey.shade300,
      ),
    );
  }
}
class _ChatSection extends StatelessWidget {
  const _ChatSection();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: const [
        _ChatBubble(isMe: false),
        _ChatBubble(isMe: true),
        _ChatBubble(isMe: false),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final bool isMe;
  const _ChatBubble({required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
      isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(maxWidth: 260),
        decoration: BoxDecoration(
          color: isMe
              ? const Color(0xFF2EC4B6)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          'Lorem ipsum dolor sit amet consectetur adipiscing elit.',
          style: TextStyle(
            color: isMe ? Colors.white : Colors.black87,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
class _InputSection extends StatelessWidget {
  const _InputSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Text Here ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: const Color(0xFF2EC4B6),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
