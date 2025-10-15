import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;
  static bool _initialized = false;

  static void initOnce(BuildContext context) {
    if (_initialized) return;
    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
    _initialized = true;
  }

  static double w(double percent, [BuildContext? context]) {
    if (!_initialized && context != null) initOnce(context);
    return blockWidth * percent;
  }

  static double h(double percent, [BuildContext? context]) {
    if (!_initialized && context != null) initOnce(context);
    return blockHeight * percent;
  }

  static double text(double size, [BuildContext? context]) {
    if (!_initialized && context != null) initOnce(context);
    return size * (screenWidth / 375);
  }

  static bool get isSmall => screenWidth < 350;

  static bool get isTablet => screenWidth > 600;

  static bool get isDesktop => screenWidth > 1000;
}


