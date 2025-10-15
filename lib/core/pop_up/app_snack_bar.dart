import 'package:flutter/material.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';

enum SnackBarType{
  success, error
}
class AppSnackBar {
  AppSnackBar._();

  /// Show a SnackBar with a message
  static void show({required BuildContext context,required String message,required SnackBarType type}) {
    // Clear previous SnackBars first
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,

        ),
        duration: Duration(seconds: 4),

        backgroundColor: type==SnackBarType.error?AppColors.redColor(context):AppColors.primaryColor(context),
      ),
    );
  }


}
