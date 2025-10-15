import 'package:flutter/material.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor(context),
      ),
    );
  }
}
