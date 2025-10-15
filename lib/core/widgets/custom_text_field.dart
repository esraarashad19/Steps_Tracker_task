import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool enabled;
  final TextDirection? textDirection;
  final int? maxLength;
  final FocusNode? focusNode;


  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.textDirection,
    this.maxLength,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusNode,
      enabled: enabled,
      validator: validator,
      onChanged: onChanged,
      maxLength: maxLength,
      cursorColor: AppColors.primaryColor(context),
      inputFormatters: [
        if( keyboardType== TextInputType.numberWithOptions(decimal: true))
          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
      ],
      style: TextStyle(
        color: AppColors.blackColor(context),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.greyColor(context),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.primaryColor(context),
            width: 1.8,
          ),
        ),
      ),
    );
  }
}
