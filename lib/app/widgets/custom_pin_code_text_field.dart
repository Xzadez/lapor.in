import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:laporin/app/core/utils/size.utils.dart';
import 'package:laporin/app/theme/theme_helper.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({
    Key? key,
    required this.context,
    required this.onChanged,
    this.controller,
    this.validator,
  }) : super(key: key);

  final BuildContext context;
  final Function(String) onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      controller: controller,
      length: 4,
      obscureText: false,
      obscuringCharacter: '*',
      keyboardType: TextInputType.number,
      autoDismissKeyboard: true,
      enableActiveFill: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
      validator: validator,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(9.h),
        fieldHeight: 50.h,
        fieldWidth: 50.h,

        // Warna saat tidak aktif (inactive)
        inactiveFillColor: Colors.white.withOpacity(0.2),
        inactiveColor: Colors.white,
        // Warna saat dipilih (selected)
        selectedFillColor: Colors.white.withOpacity(0.2),
        selectedColor: Colors.white,
        // Warna saat sudah terisi (active)
        activeFillColor: Colors.white.withOpacity(0.2),
        activeColor: Colors.white,
      ),
      cursorColor: Colors.white,
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.fSize,
        fontWeight: FontWeight.bold,
      ),
      boxShadows: [
        BoxShadow(offset: Offset(0, 1), color: Colors.black12, blurRadius: 10),
      ],
    );
  }
}
