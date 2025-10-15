import 'package:flutter/material.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';

class CustomAppButton extends StatelessWidget {
  final VoidCallback onPress;
  final String title;
  final bool isOutline;

  const CustomAppButton({super.key,required this.onPress,required this.title,this.isOutline=false});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:!isOutline? AppColors.primaryColor(context):AppColors.whiteColor(context),
        minimumSize: Size(double.infinity, 6.h),

        shape: RoundedRectangleBorder(
          side: BorderSide(color: AppColors.primaryColor(context)),
          borderRadius: BorderRadius.circular(12.h),

        ),
      ),
      onPressed:onPress,
      child: Text(
        title,
        style: TextStyle(fontSize: 18.sp, color:!isOutline? AppColors.whiteColor(context):AppColors.primaryColor(context)),
      ),
    );
  }
}
