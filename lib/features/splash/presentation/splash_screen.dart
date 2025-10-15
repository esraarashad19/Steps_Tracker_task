import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:steps_tracker/core/pop_up/app_snack_bar.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/navigation/app_navigation.dart';
import 'package:steps_tracker/core/navigation/app_routes.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_22.dart';
import 'package:steps_tracker/features/splash/domain/splash_repository.dart';
import 'package:steps_tracker/features/splash/presentation/cubit/splash_states.dart';

import '../data/splash_repository_impl.dart';
import 'cubit/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashRepository splashRepository = SplashRepositoryImpl(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(splashRepository)..listenToConnectionChanges(),
      child: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigateSetup) {
            NavigationService.pushReplacementNamed(AppRoutes.setupProfile);
          } else if (state is SplashNavigateHome) {
            NavigationService.pushReplacementNamed(AppRoutes.navigationBar);
          } else if (state is SplashError) {
            AppSnackBar.show(context: context, message: state.message, type: SnackBarType.error);
          } else if(state is SplashNoInternet){
            AppSnackBar.show(context: context, message: 'checkYourInternetConnection'.tr, type: SnackBarType.error);

          }
        },

        builder: (context,state){
          return Scaffold(
            backgroundColor: AppColors.backgroundColor(context),
            body: Center(
              child: Column(
                children: [
                  30.sh,
                  CircleAvatar(
                    radius: 10.h,
                    backgroundColor: AppColors.primaryColor(context),

                    child: SvgPicture.asset(
                      'assets/images/foots.svg',
                      height: 15.h,
                    ),
                  ),

                  1.sh,

                  CustomText22(
                    'splash_header_text'.tr,
                  ),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
