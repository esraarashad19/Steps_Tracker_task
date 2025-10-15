import 'package:cloud_firestore/cloud_firestore.dart';

class WeightModel {
  final String id;
  final double weight;
  final DateTime date;

  WeightModel({
    required this.id,
    required this.weight,
    required this.date,
  });

  factory WeightModel.fromJson(Map<String, dynamic> json, String id) {
    DateTime date;
    if (json['date'] is Timestamp) date = json['date'].toDate();
    else if (json['date'] is String) date = DateTime.parse(json['date']);
    else date = DateTime.now();

    return WeightModel(
      id: id,
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      date: date,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'date': Timestamp.fromDate(date),
    };
  }

  WeightModel copyWith({String? id, double? weight, DateTime? date}) {
    return WeightModel(
      id: id ?? this.id,
      weight: weight ?? this.weight,
      date: date ?? this.date,
    );
  }
}
