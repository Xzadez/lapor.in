import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/selected_role_controller.dart';

class SelectedRoleView extends GetView<SelectedRoleController> {
  const SelectedRoleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SelectedRoleView'), centerTitle: true),
      body: const Center(
        child: Text(
          'SelectedRoleView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
