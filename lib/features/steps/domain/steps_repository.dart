// lib/features/steps/data/repositories/steps_repository.dart

import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/features/steps/domain/step_model.dart';


abstract class StepsRepository {
  Future<Either<Failure, Unit>> logSteps(StepModel stepModel);
  Future<Either<Failure, StepModel?>> fetchLatestSteps();
}
