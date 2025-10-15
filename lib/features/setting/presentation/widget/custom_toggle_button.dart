import 'package:flutter/material.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';

class ToggleButton extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData leadingIcon;

  const ToggleButton({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    required this.leadingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.2.w, vertical: .8.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(1.2.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(leadingIcon, color: AppColors.primaryColor(context)),
              1.2.sw,

              CustomText16(title,),
            ],
          ),
          Switch(

            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primaryColor(context),
            inactiveTrackColor: AppColors.whiteColor(context),
            activeThumbColor:  AppColors.backgroundColor(context),
            focusColor: AppColors.primaryColor(context),
          ),
        ],
      ),
    );
  }
}
