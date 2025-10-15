// repositories/firestore_weight_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/weights/domain/weight_model.dart';
import 'package:steps_tracker/features/weights/domain/weight_repository.dart';

class WeightRepositoryImpl implements WeightRepository {
  final FirebaseFirestore firestore;

  WeightRepositoryImpl({required this.firestore,});

  final uid = SharedPrefService.getUserId();


  @override
  Future<Either<Failure, List<WeightModel>>> getUserWeights() async {
    try {
      if (uid.isEmpty) return left(Failure('userNotAuthenticated'.tr));

      final snap = await firestore.collection('users').doc(uid).collection('weights')
          .orderBy('date', descending: true)
          .get();

      final list = snap.docs
          .map((doc) => WeightModel.fromJson(doc.data(), doc.id))
          .toList();

      return Right(list);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firebase error while loading weights.'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> addWeight(WeightModel w) async {
    try {
      await firestore.collection('users').doc(uid).collection('weights').add(w.toJson());
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firebase error while adding weight.'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateWeight(WeightModel w) async {
    try {
      await firestore.collection('users').doc(uid).collection('weights').doc(w.id).set(w.toJson());
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firebase error while updating weight.'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteWeight(String id) async {
    try {
      await firestore.collection('users').doc(uid).collection('weights').doc(id).delete();
      return const Right(unit);
    } on FirebaseException catch (e) {
      return Left(Failure(e.message ?? 'Firebase error while deleting weight.'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }


}
