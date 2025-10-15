
abstract class SetupProfileState {}

class SetupProfileInitial extends SetupProfileState {}

class SetupProfileLoading extends SetupProfileState {}

class SetupProfileSuccess extends SetupProfileState {}

class SetupProfileError extends SetupProfileState {
  final String message;
  SetupProfileError(this.message);
}


class SuccessImagePick extends SetupProfileState {}
