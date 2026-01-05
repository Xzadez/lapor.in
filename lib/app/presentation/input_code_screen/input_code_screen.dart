import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laporin/app/presentation/input_code_screen/controller/input_code_controller.dart';
import 'package:laporin/app/widgets/custom_button.dart';
import 'package:laporin/app/widgets/custom_text_form_field.dart';

class InputCodeScreen extends GetView<InputCodeController> {
  const InputCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Masukkan Kode Undangan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              controller: controller.codeController,
              placeholder: 'Kode Undangan',
              textColor: Colors.black,
            ),
            const SizedBox(height: 16),
            Obx(
              () => CustomButton(
                text: controller.isLoading.value ? 'Loading...' : 'Submit',
                width: Get.width,
                onPressed: controller.isLoading.value ? null : controller.submitCode,
              ),
            ),
            Obx(() {
              if (controller.errorMessage.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
