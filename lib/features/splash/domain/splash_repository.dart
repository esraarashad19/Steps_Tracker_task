

import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/features/splash/domain/user_model.dart';

abstract class SplashRepository {
  Future<Either<Failure, UserModel>> signInAnonymously();
}
