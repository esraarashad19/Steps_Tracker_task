
import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/features/weights/domain/weight_model.dart';

abstract class WeightRepository {
  Future<Either<Failure, List<WeightModel>>> getUserWeights();

  Future<Either<Failure, Unit>> addWeight(WeightModel w);

  Future<Either<Failure, Unit>> updateWeight(WeightModel w);

  Future<Either<Failure, Unit>> deleteWeight(String id);
}
