import 'package:steps_tracker/core/localization/localization_extention.dart';

class FieldValidator {
  static String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'fieldRequired'.tr;
    }
    return null;
  }
}