import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/features/weights/domain/weight_model.dart';
import 'package:steps_tracker/features/weights/domain/weight_repository.dart';
import 'package:steps_tracker/features/weights/presentation/cubit/weights_states.dart';

class WeightCubit extends Cubit<WeightState> {
  final WeightRepository repo;

  WeightCubit({required this.repo}) : super(WeightInitial());

  WeightModel? editingModel;


  Future<void> getWights() async {
    emit(WeightLoading());
    final result = await repo.getUserWeights();
    result.fold(
          (failure) => emit(WeightError(failure.message)),
          (list) => emit(WeightLoaded(list)),
    );
  }

  Future<void> addWeight(double weight, DateTime date) async {
    final result = await repo.addWeight(
      WeightModel(id: '', weight: weight, date: date),
    );
    result.fold(
          (failure) => emit(WeightError(failure.message)),
          (_) => getWights(),
    );
  }

  Future<void> updateWeight(WeightModel w) async {
    final result = await repo.updateWeight(w);
    result.fold(
          (failure) => emit(WeightError(failure.message)),
          (_) => getWights(),
    );
  }

  Future<void> deleteWeight(String id) async {
    final result = await repo.deleteWeight(id);
    result.fold(
          (failure) => emit(WeightError(failure.message)),
          (_) => getWights(),
    );
  }
}
