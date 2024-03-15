import 'dart:convert';

class RateModel {
  final String userId;
  final double rating;

  RateModel(this.userId, this.rating);

 

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'rating': rating,
    };
  }

  factory RateModel.fromMap(Map<String, dynamic> map) {
    return RateModel(
      map['userId'] ?? '',
      map['rating']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RateModel.fromJson(String source) => RateModel.fromMap(json.decode(source));
}
