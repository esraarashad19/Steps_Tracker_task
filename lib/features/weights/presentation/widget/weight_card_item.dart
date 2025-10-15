import 'package:flutter/material.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_12.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/features/weights/domain/weight_model.dart';
import 'package:intl/intl.dart';


class WeightCardItem extends StatelessWidget {
  final WeightModel weightModel;
  final VoidCallback cardOnPress;

  const WeightCardItem({super.key,required this.weightModel,required this.cardOnPress});

  String formatDate(DateTime d) => DateFormat('MMM d, yyyy', SharedPrefService.getLanguage()).format(d);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.6.w, vertical: .8.h),
      child: Material(
        elevation: 0,
        color: AppColors.whiteColor(context),
        borderRadius: BorderRadius.circular(1.2.h),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 1.6.w, vertical: 1.4.h),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.blackColor(context),
                blurRadius: .3.h,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText16(
                      '${weightModel.weight.toStringAsFixed(1)} ${'kg'.tr}',
                    ),

                    .6.sh,

                    CustomText12(
                      formatDate(weightModel.date),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: cardOnPress,
                icon: const Icon(Icons.more_horiz),
                color:AppColors.primaryColor(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
