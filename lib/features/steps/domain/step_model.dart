// lib/features/steps/data/models/step_model.dart

class StepModel {
  final int steps;
  final int goal;
  final DateTime dateTime;

  StepModel({
    required this.steps,
    required this.goal,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'steps': steps,
      'goal': goal,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory StepModel.fromMap(Map<String, dynamic> json) {
    return StepModel(
      steps: json['steps'] ?? 0,
      goal: json['goal'] ?? 10000,
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
