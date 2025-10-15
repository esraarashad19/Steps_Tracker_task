import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/setting/presentation/cubit/setting_states.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial()) {
    loadSystemSettings();
  }

  late bool isDark ;
  late bool isEnglish;

  Future<void> loadSystemSettings() async {
    final themeMode =await SharedPrefService.getThemeMode();
    isDark = themeMode == ThemeMode.dark;

    final systemLocale =await SharedPrefService.getLanguage();
    isEnglish = systemLocale == 'en';

    emit(SettingsUpdated(isDark: isDark, isEnglish: isEnglish));
  }

  /// change theme
  void toggleTheme() {
    isDark = !isDark;
    SharedPrefService.setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
    emit(SettingsUpdated(isDark: isDark, isEnglish: isEnglish));
  }


  /// change language
  void toggleLanguage() {
    isEnglish = !isEnglish;
    SharedPrefService.setLanguage(isEnglish ? 'en' : 'ar');
    emit(SettingsUpdated(isDark: isDark, isEnglish: isEnglish));
  }

  /// sign out
  Future<void> signOut() async {
    emit(SettingsSignOutLoading());
    try {
      await clearUserDataOnSignOut();
      await FirebaseAuth.instance.signOut();

      await Future.delayed(const Duration(seconds: 4));

      emit(SettingsSignOutSuccess());
    } catch (e) {
      emit(SettingsSignOutError(message: e.toString()));
    }
  }


  /// clear pref
  Future<void> clearUserDataOnSignOut() async {
    final String language = SharedPrefService.getLanguage();
    final ThemeMode themeMode = SharedPrefService.getThemeMode();

    await SharedPrefService.clearAll();

    await SharedPrefService.setLanguage(language);
    await SharedPrefService.setThemeMode(
      themeMode == ThemeMode.dark ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
