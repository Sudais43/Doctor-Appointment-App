import 'dart:convert';

class DoctorInfo {
  final String name;
  final String Department;
  final bool isFavorite;
  final double rating;
  final int messages;
  String images;
  final String gender;

  DoctorInfo({
    required this.name,
    required this.Department,
    required this.isFavorite,
    required this.rating,
    required this.messages,
    required this.images,
    required this.gender,
  });

  DoctorInfo copyWith({
    String? name,
    String? Department,
    bool? isFavorite,
    double? rating,
    int? messages,
    String? images,
    String? gender,
  }) => DoctorInfo(
    name: name ?? this.name,
    Department: Department ?? this.Department,
    isFavorite: isFavorite ?? this.isFavorite,
    rating: rating ?? this.rating,
    messages: messages ?? this.messages,
    images: images ?? this.images,
    gender: gender ?? this.gender,
  );

  factory DoctorInfo.fromJson(String str) => DoctorInfo.fromJson(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorInfo.fromMap(Map<String, dynamic> json) => DoctorInfo(
    name: json["name"],
    Department: json["Department"],
    isFavorite: json["isFavorite"],
    rating: json["rating"],
    messages: json["messages"],
    images: json["images"],
    gender: json["gender"],
  );

  Map<String , dynamic> toMap() => {
    "name": name,
    "Department": Department,
    "isFavorite": isFavorite,
    "rating": rating,
    "messages": messages,
    "images" : images,
    "gender": gender,
  };

}
