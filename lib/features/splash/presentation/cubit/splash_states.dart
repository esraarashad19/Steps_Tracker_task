
import 'package:steps_tracker/features/splash/domain/user_model.dart';

abstract class SplashState {}
class SplashInitial extends SplashState {}
class SplashLoading extends SplashState {}
class SplashSuccess extends SplashState {
  final UserModel user;
  SplashSuccess(this.user);
}
class SplashError extends SplashState {
  final String message;

  SplashError({required this.message});
}

class SplashNavigateSetup extends SplashState {}

class SplashNavigateHome extends SplashState {}

class SplashNoInternet extends SplashState {}