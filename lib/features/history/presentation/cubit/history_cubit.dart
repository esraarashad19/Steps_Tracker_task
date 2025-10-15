import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/features/history/domain/history_repository.dart';
import 'package:steps_tracker/features/history/presentation/cubit/history_state.dart';



class StepsHistoryCubit extends Cubit<StepsHistoryState> {
  final StepsHistoryRepository repository;
  StepsHistoryCubit(this.repository) : super(StepsInitial());

  Future<void> getStepsHistory() async {
    emit(StepsLoading());
    final result = await repository.getStepsHistory();

    result.fold(
          (failure) => emit(StepsError(message: failure.message)),
          (stepsList) => emit(StepsLoaded(steps: stepsList??[],)),
    );
  }
}
