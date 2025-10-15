import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/core/localization/app_localization.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/theme/app_colors.dart';
import 'package:steps_tracker/core/utils/size_extension.dart';
import 'package:steps_tracker/core/widgets/custom_progress_indicator.dart';
import 'package:steps_tracker/core/widgets/texts/custom_text_16.dart';
import 'package:steps_tracker/features/setting/presentation/widget/custom_toggle_button.dart';

import 'cubit/setting_cubit.dart';
import 'cubit/setting_states.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        if(state is SettingsSignOutSuccess){
          SystemNavigator.pop();
        }
        final cubit = context.read<SettingsCubit>();
        return Scaffold(
          backgroundColor: AppColors.backgroundColor(context),
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor(context),
            title: Text(AppLocalizations.of(context).translate('settings')),
            centerTitle: true,
          ),
          body: ListView(
            padding: EdgeInsets.all(1.6.h),
            children: [
              ToggleButton(
                title: 'darkTheme'.tr,
                value: cubit.isDark,
                onChanged: (_) => cubit.toggleTheme(),
                leadingIcon: Icons.dark_mode,
              ),
              1.6.sh,
              ToggleButton(
                title: "${cubit.isEnglish ? 'english'.tr : 'arabic'.tr}",
                value: cubit.isEnglish,
                onChanged: (_) => cubit.toggleLanguage(),
                leadingIcon: Icons.language,
              ),
              6.sh,


              if(state is SettingsSignOutLoading)
                CustomProgressIndicator(),

              if( state is! SettingsSignOutLoading)
                TextButton(
                  onPressed: ()=>cubit.signOut(),
                  child: CustomText16('signOut'.tr,color: AppColors.redColor(context),),
                )

            ],
          ),
        );
      },
    );
  }
}
