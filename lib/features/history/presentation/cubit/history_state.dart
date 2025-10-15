import 'package:steps_tracker/features/steps/domain/step_model.dart';

abstract class StepsHistoryState {}

class StepsInitial extends StepsHistoryState {}

class StepsLoading extends StepsHistoryState {}

class StepsLoaded extends StepsHistoryState {
  final List<StepModel> steps;
  StepsLoaded({required this.steps});
}

class StepsError extends StepsHistoryState {
  final String message;
  StepsError({required this.message});
}
