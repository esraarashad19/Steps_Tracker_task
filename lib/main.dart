
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:steps_tracker/core/navigation/app_navigation.dart';
import 'core/localization/app_localization.dart';
import 'core/navigation/app_routes.dart';
import 'core/services/shared_pref_service.dart';
import 'core/utils/size_config.dart';
import 'features/setting/presentation/cubit/setting_cubit.dart';
import 'features/setting/presentation/cubit/setting_states.dart';
import 'firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPrefService.init();

  runApp(MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider(
      create: (_) => SettingsCubit()..loadSystemSettings(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context,state){
          SizeConfig.initOnce(context);

          return MaterialApp(
            title: 'Clean Flutter App',
            debugShowCheckedModeBanner: false,

            navigatorKey: appNavigatorKey,
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: AppRoutes.splash,
            theme: context.watch<SettingsCubit>().isDark
                ? ThemeData.dark()
                : ThemeData.light(),
            locale: context.watch<SettingsCubit>().isEnglish
                ? const Locale('en')
                : const Locale('ar'),
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
