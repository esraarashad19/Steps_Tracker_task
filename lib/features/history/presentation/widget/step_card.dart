import 'package:flutter/material.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/features/steps/domain/step_model.dart';

class StepCard extends StatelessWidget {
  final StepModel stepModel;
  const StepCard(this.stepModel);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.h)),
      child: ListTile(
        leading:  Icon(Icons.directions_walk, color: AppColors.primaryColor(context)),
        title: CustomText16('${stepModel.steps} steps'),
        trailing: CustomText16('${stepModel.dateTime.day}/${stepModel.dateTime.month}'),
      ),
    );
  }
}