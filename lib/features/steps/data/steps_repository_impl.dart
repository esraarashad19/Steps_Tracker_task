
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/steps/domain/step_model.dart';
import 'package:steps_tracker/features/steps/domain/steps_repository.dart';


class StepsRepositoryImpl implements StepsRepository {
  final FirebaseFirestore firestore;

  StepsRepositoryImpl({
    required this.firestore,
  });

  @override
  Future<Either<Failure, Unit>> logSteps(StepModel stepModel) async {
    try {
      final uid = await SharedPrefService.getUserId();
      if (uid.isEmpty) return left( Failure('userNotAuthenticated'.tr));

      await firestore
          .collection('users')
          .doc(uid)
          .collection('steps')
          .doc(DateTime.now().toIso8601String())
          .set(stepModel.toMap());

      return right(unit);
    } catch (e) {
      return left(Failure('Failed to log steps: $e'));
    }
  }

  @override
  Future<Either<Failure, StepModel?>> fetchLatestSteps() async {
    try {
      final uid = await SharedPrefService.getUserId();
      if (uid.isEmpty) return left( Failure('userNotAuthenticated'.tr));

      final snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('steps')
          .orderBy('dateTime', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return right(null);

      return right(StepModel.fromMap(snapshot.docs.first.data()));
    } catch (e) {
      return left(Failure('Failed to fetch steps: $e'));
    }
  }
}
