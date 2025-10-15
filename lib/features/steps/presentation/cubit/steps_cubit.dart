// lib/features/steps/presentation/cubit/steps_cubit.dart

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:steps_tracker/core/services/shared_pref_service.dart';
import 'package:steps_tracker/features/steps/domain/step_model.dart';
import 'package:steps_tracker/features/steps/domain/steps_repository.dart';
import 'package:steps_tracker/features/steps/presentation/cubit/steps_state.dart';

class StepsCubit extends Cubit<StepsState> {
  final StepsRepository repository;

  final int goal = 15000;

  Stream<StepCount>? stepStream;
  int latestStepCount = 0;
  int baseSteps = 0;

  Timer? timer;


  StepsCubit(this.repository) : super(StepsInitial());

  Future<void> startTracking() async {
    final status = await Permission.activityRecognition.request();
    if (!status.isGranted) {
      emit(StepsError(message: 'Activity Recognition permission denied'));
      return;
    }
    await initBaseSteps();

    try {
      stepStream = Pedometer.stepCountStream;
      stepStream?.listen(
            (StepCount event) {
          if (baseSteps == 0) {
            baseSteps = event.steps;
            SharedPrefService.setBaseSteps( baseSteps);
          }
          final stepsToday = event.steps - baseSteps;
          latestStepCount = stepsToday < 0 ? 0 : stepsToday;
          startTimer();
        },
        onError: (e) {
          print(e.toString());
          emit(StepsError(message: e.toString()));
        },
      );
    } catch (e) {
      emit(StepsError(message: e.toString()));
    }
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;
      emit(StepsUpdated(steps: latestStepCount,currentTime: DateTime.now()));
    });
  }


  /// handle new day steps because pedometer package return all phone steps
  Future<void> initBaseSteps() async {
    final lastDate = SharedPrefService.getLastDate();
    final today = DateTime.now().toIso8601String().substring(0, 10);

    if (lastDate != today) {
      SharedPrefService.setLastDate(today);
      SharedPrefService.setBaseSteps(0);
      baseSteps = 0;
    } else {
      baseSteps = SharedPrefService.getBaseSteps() ?? 0;
    }
  }

  Future<void> logCurrentSteps(int goal) async {
    final model = StepModel(
      steps: latestStepCount,
      goal: goal,
      dateTime: DateTime.now(),
    );

    emit(StepsLoading());
    final result = await repository.logSteps(model);

    result.fold(
          (failure) => emit(StepsError(message: failure.message)),
          (_) => emit(StepsLoggedSuccessfully(steps: latestStepCount)),
    );
  }

  Future<void> loadLatestSteps() async {
    emit(StepsLoading());
    final result = await repository.fetchLatestSteps();

    result.fold(
          (failure) => emit(StepsError(message: failure.message)),
          (stepModel) {
        if (stepModel == null) {
          emit(StepsUpdated(steps: 0,currentTime: DateTime.now()));
        } else {
          latestStepCount = stepModel.steps;
          emit(StepsUpdated(steps: stepModel.steps,currentTime: DateTime.now()));
        }
      },
    );
  }
}
