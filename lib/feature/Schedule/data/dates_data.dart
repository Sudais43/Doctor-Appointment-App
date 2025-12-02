final Set<DateTime> availableDates = {
  // We use .utc to ensure consistent date comparison
  DateTime.utc(2025, 11, 10),
  DateTime.utc(2025, 11, 11),
  DateTime.utc(2025, 11, 12),
  DateTime.utc(2025, 11, 15),
  DateTime.utc(2025, 11, 18),
  DateTime.utc(2025, 11, 24), // This will be selectable
  DateTime.utc(2025, 11, 26),
};