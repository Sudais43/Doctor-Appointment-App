class AppNotification {
  final String title;
  final String body;
  final DateTime timestamp;
  bool isRead;

  AppNotification({
    required this.title,
    required this.body,
    required this.timestamp,
    this.isRead = false,
  });

  // To save to Hive (convert to Map)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  // To load from Hive (convert from Map)
  factory AppNotification.fromMap(Map<dynamic, dynamic> map) {
    return AppNotification(
      title: map['title'] ?? 'No Title',
      body: map['body'] ?? '',
      isRead: map['isRead'] ?? false,
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}