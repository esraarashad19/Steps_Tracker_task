import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/history/domain/history_repository.dart';
import 'package:steps_tracker/features/steps/domain/step_model.dart';

class StepsHistoryRepositoryImpl implements StepsHistoryRepository {
  final FirebaseFirestore firestore;

  StepsHistoryRepositoryImpl({
    required this.firestore,
  });



  @override
  Future<Either<Failure,List<StepModel>?>> getStepsHistory() async {
    try {

      final uid = await SharedPrefService.getUserId();
      if (uid.isEmpty) return left( Failure('userNotAuthenticated'.tr));

      final snapshot = await firestore
          .collection('users')
          .doc(uid)
          .collection('steps')
          .orderBy('dateTime', descending: true)
          .get();


      if (snapshot.docs.isEmpty) return right(null);
      final stepsList = snapshot.docs.map((doc) => StepModel.fromMap(doc.data())).toList();

      return right(stepsList);
    } catch (e) {
      return left(Failure('${'failedToFetchSteps'.tr}: $e'));
    }
  }


}