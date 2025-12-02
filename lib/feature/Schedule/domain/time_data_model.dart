enum TimeStatus { available, booked, disabled }

class TimeSlot {
  final String time;
  final TimeStatus status;

  TimeSlot(this.time, {this.status = TimeStatus.available});
}