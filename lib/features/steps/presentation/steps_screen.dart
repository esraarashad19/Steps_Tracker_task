
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/core/pop_up/app_snack_bar.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/custom_app_button.dart';
import 'package:steps_tracker/core/widgets/custom_progress_indicator.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_12.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_22.dart';
import 'package:steps_tracker/features/steps/data/steps_repository_impl.dart';
import 'package:steps_tracker/features/steps/presentation/cubit/steps_cubit.dart';
import 'package:steps_tracker/features/steps/presentation/cubit/steps_state.dart';

class StepsScreen extends StatelessWidget {
  const StepsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=>StepsCubit(StepsRepositoryImpl(firestore: FirebaseFirestore.instance,))
      ..startTracking()..loadLatestSteps(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        body: BlocConsumer<StepsCubit, StepsState>(
          listener: (context, state) {
            if (state is StepsError) {
              AppSnackBar.show(context: context, message: state.message, type: SnackBarType.error);
            } else if (state is StepsLoggedSuccessfully) {
              AppSnackBar.show(context: context, message: 'stepsLoggedSuccessfully'.tr, type: SnackBarType.success);
            }
          },
          builder: (context, state) {
            final cubit=context.read<StepsCubit>();

            if (state is StepsLoading) {
              return const CustomProgressIndicator();
            }

            return Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  4.sh,

                  CustomText22('stepsTracker'.tr),
                  4.sh,


                  Text(
                    cubit.latestStepCount.toString(),
                    style:  TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor(context),
                    ),
                  ),

                  CustomText16(
                    'steps'.tr, color: AppColors.greyColor(context),
                  ),

                  8.sh,

                  CustomText16(
                    '${'currentTime'.tr}: ${TimeOfDay.now().format(context)}',
                  ),

                  CustomText12('trackingActive'.tr),


                  1.6.sh,

                  LinearProgressIndicator(
                    value: (cubit.latestStepCount / cubit.goal).clamp(0.0, 1.0),
                    color: Colors.teal,
                    backgroundColor: Colors.grey.shade300,
                    minHeight: .8.h,
                  ),

                  .8.sh,

                  CustomText12('${'goal'.tr}: ${cubit.goal}'),
                  const Spacer(),

                  if(cubit.latestStepCount > 0)
                    CustomAppButton(
                      title: 'logCurrentSteps'.tr,
                      onPress: () => context.read<StepsCubit>().logCurrentSteps(cubit.goal),
                    ),


                  2.sh,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
