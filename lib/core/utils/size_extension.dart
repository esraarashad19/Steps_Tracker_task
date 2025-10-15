import 'package:steps_tracker/core/utils/size_config.dart';
import 'package:flutter/material.dart';

extension ResponsiveExtensions on num {
  double get w => SizeConfig.w(toDouble());
  double get h => SizeConfig.h(toDouble());
  double get sp => SizeConfig.text(toDouble());

  /// Returns a SizedBox with height = this * blockHeight
  SizedBox get sh => SizedBox(height: this * SizeConfig.blockHeight);

  /// Returns a SizedBox with width = this * blockWidth
  SizedBox get sw => SizedBox(width: this * SizeConfig.blockWidth);

}