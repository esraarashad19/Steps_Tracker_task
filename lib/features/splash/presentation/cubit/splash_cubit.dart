import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/splash/domain/splash_repository.dart';
import 'splash_states.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository splashRepository;

  SplashCubit(this.splashRepository) : super(SplashInitial());




  void listenToConnectionChanges() {
    InternetConnection().onStatusChange.listen((status) async {
      if (status == InternetStatus.connected) {
        await checkUser();
      } else {
        emit(SplashNoInternet());
      }
    });
  }

  /// check if user already logged in
  Future<void> checkUser() async {
    await Future.delayed(const Duration(seconds: 2));

    try {
      if (SharedPrefService.isUserLoggedIn()) {
        if (SharedPrefService.hasProfileData()) {
          emit(SplashNavigateHome());
        } else {
          emit(SplashNavigateSetup());
        }
      } else {
        await signInAnonymously();
      }
    } catch (e) {
      emit(SplashError(message: 'Failed to load user data: $e'));
    }
  }


  /// sign in Anonymously with firebase
  Future<void> signInAnonymously() async {
    final result = await splashRepository.signInAnonymously();

    result.fold(
          (failure) => emit(SplashError(message: failure.message)),
          (user) {
        if (SharedPrefService.hasProfileData()) {
          emit(SplashNavigateHome());
        } else {
          SharedPrefService.setUserId(user.uid);
          emit(SplashNavigateSetup());
        }
      },
    );
  }
}
