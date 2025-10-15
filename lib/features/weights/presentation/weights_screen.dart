import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/custom_progress_indicator.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/features/weights/data/weight_repository_imp.dart';
import 'package:steps_tracker/features/weights/presentation/controllers/weight_sheet_controller.dart';
import 'package:steps_tracker/features/weights/presentation/widget/weight_card_item.dart';

import 'cubit/weights_cubit.dart';
import 'cubit/weights_states.dart';



class WeightHistoryScreen extends StatelessWidget {
  const WeightHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>WeightCubit(repo: WeightRepositoryImpl(firestore: FirebaseFirestore.instance ))..getWights(),

      child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: AppColors.backgroundColor(context),
              body: BlocBuilder<WeightCubit, WeightState>(
                builder: (context, state) {
                  final cubit = context.read<WeightCubit>();


                  if (state is WeightLoading || state is WeightInitial) {
                    return const CustomProgressIndicator();
                  } else if (state is WeightError) {
                    return Center(child: CustomText16('Error: ${state.message}'));
                  }else if (state is WeightLoaded) {
                    if (state.weights.isEmpty) {
                      return  Center(child: CustomText16('noWeight'.tr));
                    }
                    return ListView.builder(
                      padding:  EdgeInsets.only(top: 1.6.h, bottom: 10.h),
                      itemCount: state.weights.length,
                      itemBuilder: (context, i) => WeightCardItem(
                            weightModel: state.weights[i],
                            cardOnPress: () =>
                                WeightUIController.openWeightSheet(
                                  parentContext: context, weightModel: state.weights[i],
                                  cubit:cubit,
                                ),
                          ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              floatingActionButton: Padding(
                padding:  EdgeInsets.only(bottom: 1.8.h),
                child: FloatingActionButton(
                  onPressed: () => WeightUIController.openWeightSheet(parentContext: context,cubit: context.read<WeightCubit>()),
                  backgroundColor: AppColors.primaryColor(context),
                  child:  Icon(Icons.add, size: 2.8.h,color: AppColors.whiteColor(context),),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            );
          }
      ),
    );
  }
}
