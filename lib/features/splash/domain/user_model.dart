class UserModel {
  final String uid;
  final String? name;
  final double? weight;
  final DateTime? createdAt;

  const UserModel({
    required this.uid,
    this.name,
    this.weight,
    this.createdAt,
  });

  // Convert to Map (for Firebase)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'weight': weight,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  // Convert from Map (from Firebase)
  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'],
      weight:json['weight'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
