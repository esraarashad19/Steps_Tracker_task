import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPrefService {
  static SharedPreferences? _prefs;
  static bool _initialized = false;

  // Keys
  static const _languageCode = 'language_code';
  static const _themeMode = 'theme_mode';
  static const _isUserLoggedIn = 'is_user_logged_in';
  static const _userId = 'user_id';
  static const _userName = 'user_name';
  static const _userImage = 'user_Image';
  static const _userWeight = 'user_weight';
  static const _lastDate = 'last_day';
  static const _baseSteps = 'base_steps';


  /// Initialize once before using (in main.dart)
  static Future<void> init() async {
    if (_initialized) return;
    _prefs = await SharedPreferences.getInstance();
    _initialized = true;
  }

  static SharedPreferences get _safePrefs {
    if (_prefs == null) {
      throw Exception(
        'SharedPrefService not initialized. Call SharedPrefService.init() first.',
      );
    }
    return _prefs!;
  }

  /// language
  static setLanguage(String code) {
    _safePrefs.setString(_languageCode, code);
  }

  static String getLanguage() => _safePrefs.getString(_languageCode) ?? window.locale.languageCode;

  static Locale getLocale() => Locale(getLanguage());


  /// theme
  static Future<void> setThemeMode(ThemeMode mode) async {
    await _safePrefs.setString(_themeMode, mode.name);
  }

  static ThemeMode getThemeMode() {
    final theme = _safePrefs.getString(_themeMode);
    switch (theme) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }



  /// Save user ID (Firebase UID)
  static Future<void> setUserId(String uid) async {
    await _safePrefs.setString(_userId, uid);
    await _safePrefs.setBool(_isUserLoggedIn, true);
  }

  static bool isUserLoggedIn() => _safePrefs.getBool(_isUserLoggedIn) ?? false;

  static String getUserId() => _safePrefs.getString(_userId) ?? '';

  static Future<void> setUserName(String name) async {
    await _prefs?.setString(_userName, name);
  }

  static String? getUserName() => _prefs?.getString(_userName);

  /// user weight
  static Future<void> setUserWeight(double weight) async {
    await _prefs?.setDouble(_userWeight, weight);
  }

  static double? getUserWeight() => _prefs?.getDouble(_userWeight);

  /// user image
  static Future<void> setUserImage(String imageURL) async {
    await _prefs?.setString(_userImage, imageURL);
  }

  static String? getUserImage() => _prefs?.getString(_userImage);

/// last date of steps
  static Future<void> setLastDate(String date) async {
    await _prefs?.setString(_lastDate, date);
  }

  static String? getLastDate() => _prefs?.getString(_lastDate);

  /// last steps
  static Future<void> setBaseSteps(int steps) async {
    await _prefs?.setInt(_baseSteps, steps);
  }

  static int? getBaseSteps() => _prefs?.getInt(_baseSteps);

  static bool hasProfileData()  {
    final name = _prefs?.getString(_userName);
    final weight = _prefs?.getDouble(_userWeight);
    return name != null && name.isNotEmpty && weight != null ;
  }



  static Future<void> clearAll() async => _safePrefs.clear();
}
