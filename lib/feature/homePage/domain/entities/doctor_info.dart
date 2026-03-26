import 'dart:convert';

class DoctorInfo {
  final String id;
  final String name;
  final String speciality;
  final bool isFavorite;
  final double rating;
  final int reviews;
  String imageUrl;
  final String gender;
  final List<dynamic> availability;

  DoctorInfo({
    required this.id,
    required this.name,
    required this.speciality,
    required this.isFavorite,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.gender,
    required this.availability,
  });

  DoctorInfo copyWith({
    String? id,
    String? name,
    String? speciality,
    bool? isFavorite,
    double? rating,
    int? reviews,
    String? images,
    String? gender,
    List<dynamic>? availability,
  }) => DoctorInfo(
    id: id ?? this.id,
    name: name ?? this.name,
    speciality: speciality ?? this.speciality,
    isFavorite: isFavorite ?? this.isFavorite,
    rating: rating ?? this.rating,
    reviews: reviews ?? this.reviews,
    imageUrl: imageUrl ?? this.imageUrl,
    gender: gender ?? this.gender,
    availability: availability ?? this.availability,
  );

  factory DoctorInfo.fromJson(String str) => DoctorInfo.fromJson(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DoctorInfo.fromMap(Map<String, dynamic> json) => DoctorInfo(
    id: json["id"] ?? '',
    name: json["name"],
    speciality: json["speciality"],
    isFavorite: json["isFavorite"],
    rating: json["rating"],
    reviews: json["reviews"],
    imageUrl: json["imageUrl"],
    gender: json["gender"],
    availability: json["availability"] ?? [],
  );

  Map<String , dynamic> toMap() => {
    "id": id,
    "name": name,
    "speciality": speciality,
    "isFavorite": isFavorite,
    "rating": rating,
    "reviews": reviews,
    "imageUrl" : imageUrl,
    "gender": gender,
    "availability": availability,
  };

}
