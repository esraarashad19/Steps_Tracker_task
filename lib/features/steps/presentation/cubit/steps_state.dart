
abstract class StepsState {}

class StepsInitial extends StepsState {}

class StepsLoading extends StepsState {}

class StepsUpdated extends StepsState {
  final int steps;
  final DateTime currentTime;
  StepsUpdated({required this.steps,required this.currentTime});
}

class StepsLoggedSuccessfully extends StepsState {
  final int steps;
  StepsLoggedSuccessfully({required this.steps});
}

class StepsError extends StepsState {
  final String message;
  StepsError({required this.message});
}
