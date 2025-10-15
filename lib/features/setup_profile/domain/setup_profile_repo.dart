import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';

abstract class SetupProfileRepository {
  Future<Either<Failure, Unit>>  saveUserProfile({
    required String userId,
    required String name,
    required double weight,
    File? profileImage,
  });
}
