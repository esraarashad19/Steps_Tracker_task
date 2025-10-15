import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/core/pop_up/app_snack_bar.dart';
import 'package:steps_tracker/core/error/text_field_validition.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/navigation/app_navigation.dart';
import 'package:steps_tracker/core/navigation/app_routes.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/custom_app_button.dart';
import 'package:steps_tracker/core/widgets/custom_progress_indicator.dart';
import 'package:steps_tracker/core/widgets/custom_text_field.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_22.dart';
import 'package:steps_tracker/features/setup_profile/data/setup_profile_repository_imp.dart';
import 'package:steps_tracker/features/setup_profile/presentation/cubit/setup_profile_cubit.dart';

import 'cubit/setup_profile_states.dart';


class SetupProfileScreen extends StatefulWidget {
  SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final formKey = GlobalKey<FormState>();

  final nameFocusNode = FocusNode();

  final weightFocusNode = FocusNode();

  final nameController = TextEditingController();

  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SetupProfileCubit(
            SetupProfileRepositoryImpl(
              FirebaseFirestore.instance,
              FirebaseStorage.instance,
            ),
          ),
      child: BlocConsumer<SetupProfileCubit,SetupProfileState>(
        listener: (context, state) {

          if (state is SetupProfileSuccess) {
            NavigationService.pushReplacementNamed(AppRoutes.navigationBar);
          } else if (state is SetupProfileError) {
            AppSnackBar.show(context: context, message: state.message, type: SnackBarType.error);
          }
        },
        builder: (context,state){
          final cubit = context.read<SetupProfileCubit>();

          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.translucent,
            child: Scaffold(
              backgroundColor: AppColors.backgroundColor(context),
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6.w),
                    child: Center(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            10.sh,
                            CustomText22(
                              'completeProfile'.tr,
                            ),


                            5.sh,

                            GestureDetector(
                              onTap: cubit.pickImage,
                              child: CircleAvatar(
                                radius: 8.h,
                                backgroundColor: AppColors.primaryColor(context),
                                backgroundImage: cubit.profileImage != null
                                    ? FileImage(cubit.profileImage!)
                                    : null,
                                child: cubit.profileImage == null
                                    ?  Icon(Icons.camera_alt, size: 6.h, color: AppColors.whiteColor(context))
                                    : null,
                              ),
                            ),
                            3.sh,

                            CustomText16(
                              'addProfilePhoto'.tr,
                            ),

                            3.sh,

                            CustomTextField(
                              controller:  nameController,
                              focusNode: nameFocusNode,
                              hintText: 'yourName'.tr,
                              validator: (String)=>FieldValidator.validateField(nameController.text),

                            ),

                            1.sh,

                            CustomTextField(
                              controller:  weightController,
                              keyboardType: TextInputType.number,
                              focusNode: weightFocusNode,
                              hintText: 'currentWeight'.tr,
                              maxLength: 4,
                              validator: (String)=>FieldValidator.validateField(weightController.text),

                            ),

                            6.sh,

                            Visibility(
                              visible: state is SetupProfileLoading,
                              child: CustomProgressIndicator(),
                              replacement: CustomAppButton(
                                title: 'startTracking'.tr,
                                onPress: ()=>cubit.startTrackingOnPress(
                                      formKey: formKey,
                                      name: nameController.text,
                                      weight: weightController.text,
                                    ),
                              ),
                            )


                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },

      ),

    );
  }
}
