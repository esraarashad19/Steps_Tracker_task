import 'package:flutter/material.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';

/// text with font size 12
class CustomText12 extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  CustomText12(
      this.text, {
        super.key,
        this.color,
        this.textAlign,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: 12.sp,
        color: color?? AppColors.lightGrey(context),
        fontWeight: FontWeight.w400,

      ),
    );
  }
}