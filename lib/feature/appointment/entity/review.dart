class DoctorReview {
  final String id;
  final String userName;
  final double rating;
  final String comment;
  final DateTime createdAt;

  DoctorReview({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });

  factory DoctorReview.fromJson(Map<String, dynamic> json) {
    final userData = json['userId'] as Map<String, dynamic>? ?? {};

    return DoctorReview(
      id: json['_id'] ?? '',
      userName: userData['fullName'] ?? 'Ananymous',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}
