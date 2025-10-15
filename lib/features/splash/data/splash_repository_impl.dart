import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_tracker/core/error/failure.dart';
import 'package:steps_tracker/core/localization/localization_extention.dart';
import 'package:steps_tracker/features/splash/domain/user_model.dart';
import 'package:steps_tracker/features/splash/domain/splash_repository.dart';


class SplashRepositoryImpl implements SplashRepository {
  late final  FirebaseAuth firebaseAuth;

  SplashRepositoryImpl(this.firebaseAuth);

  @override
  Future<Either<Failure, UserModel>> signInAnonymously() async {
    try {
      final userCredential = await firebaseAuth.signInAnonymously();
      final user = userCredential.user;

      if (user == null) {
        return Left( Failure('failedSignIn'.tr));
      }

      final userModel = UserModel(uid: user.uid,);
      return Right(userModel);
      // success
    } on FirebaseAuthException catch (e) {
      return Left(Failure('Firebase error: ${e.message ?? e.code}'));
    } catch (e) {
      return Left(Failure('Unexpected error: $e'));
    }
  }
}
