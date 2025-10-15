import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/features/steps/domain/step_model.dart';

abstract class StepsHistoryRepository {
  Future<Either<Failure, List<StepModel>?>> getStepsHistory();
}