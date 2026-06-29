class CalendarEvent {
  final String id;
  final String rpagId;
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String time;

  const CalendarEvent({
    required this.id,
    required this.rpagId,
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.time,
  });
}
