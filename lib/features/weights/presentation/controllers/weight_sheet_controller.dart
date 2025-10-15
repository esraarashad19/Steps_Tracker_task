import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/features/weights/domain/weight_model.dart';
import 'package:steps_tracker/features/weights/presentation/cubit/weights_cubit.dart';
import 'package:steps_tracker/features/weights/presentation/widget/weight_bottom_sheet.dart';


class WeightUIController {
  static Future<void> openWeightSheet({
    required BuildContext parentContext,
    required WeightCubit cubit,
    WeightModel? weightModel,
  }) async {
    await showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return BlocProvider.value(
          value: cubit,
          child: WeightBottomSheet(
              model: weightModel,
              onSave: (weight, date) {
                if (weightModel == null) {
                  cubit.addWeight(weight, date);
                } else {
                  cubit.updateWeight(weightModel.copyWith(weight: weight, date: date));
                }
              },
              onDelete: weightModel == null
                  ? null
                  : () {
                parentContext.read<WeightCubit>().deleteWeight(weightModel.id);
                Navigator.of(parentContext).pop();
              }
          ),
        );
      },
    );
  }
}
