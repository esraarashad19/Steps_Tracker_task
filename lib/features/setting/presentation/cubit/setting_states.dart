abstract class SettingsState {}

class SettingsInitial extends SettingsState {}

class SettingsUpdated extends SettingsState {
  final bool isDark;
  final bool isEnglish;

  SettingsUpdated({
    required this.isDark,
    required this.isEnglish,
  });
}

class SettingsSignOutLoading extends SettingsState {}

class SettingsSignOutSuccess extends SettingsState {}

class SettingsSignOutError extends SettingsState {
  final String message;

  SettingsSignOutError({required this.message});
}
