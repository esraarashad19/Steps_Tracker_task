import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/custom_progress_indicator.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/features/history/data/history_repository_impl.dart';
import 'package:steps_tracker/features/history/presentation/cubit/history_cubit.dart';
import 'package:steps_tracker/features/history/presentation/cubit/history_state.dart';
import 'package:steps_tracker/features/history/presentation/widget/custom_weekly_chart.dart';
import 'package:steps_tracker/features/history/presentation/widget/step_card.dart' ;


class StepsHistoryScreen extends StatelessWidget {
  const StepsHistoryScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StepsHistoryCubit(StepsHistoryRepositoryImpl(firestore:FirebaseFirestore.instance))..getStepsHistory(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        body: BlocBuilder<StepsHistoryCubit, StepsHistoryState>(
          builder: (context, state) {
            if (state is StepsLoading) {
              return  CustomProgressIndicator();
            } else if (state is StepsError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is StepsLoaded) {
              if(state.steps.isEmpty) {

                /// no steps were logged
                return Center(
                  child: CustomText16('noStepsLogged'.tr),
                );
              }
              return RefreshIndicator(
                onRefresh: () async => context.read<StepsHistoryCubit>().getStepsHistory(),
                child: ListView(
                  padding:  EdgeInsets.all(2.h),
                  children: [
                    WeeklyChart(stepsList: state.steps,),
                    1.6.sh,
                    ...state.steps.map((e) => StepCard(e)).toList(),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}






