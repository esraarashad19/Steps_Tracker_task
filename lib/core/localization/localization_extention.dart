import 'package:steps_tracker/core/localization/app_localization.dart';
import 'package:steps_tracker/core/navigation/app_navigation.dart';



extension GlobalLocalizationExtension on String {
  /// Translate static text using the global [appNavigatorKey].
  String get tr {
    final context = appNavigatorKey.currentContext;
    if (context == null) return this;
    return AppLocalizations.of(context).translate(this);
  }


  String trf(Map<String, String> params) {
    final context = appNavigatorKey.currentContext;
    if (context == null) return this;
    String value = AppLocalizations.of(context).translate(this);
    params.forEach((key, replacement) {
      value = value.replaceAll('{$key}', replacement);
    });
    return value;
  }
}
