class Petition {
  String day;
  String date;
  String? time;
  String? message; // Optional message

  Petition({
    required this.day,
    required this.date,
    required this.time,
    this.message='',
  });

  @override
  String toString() {
    return 'Solicitude(day: $day, date: $date, time: $time, message: $message)';
  }
}

Petition createSolicitude(List<String> days, List<String> dates, int index, {String? message}) {
  if (index < 0 || index >= days.length || index >= dates.length) {
    throw RangeError('Index is out of range for the provided lists.');
  }

  String day = days[index];
  String date = dates[index];
  String time = DateTime.now().toLocal().toString().split(' ')[1].substring(0, 5); // Current time in HH:mm format

  return Petition(day: day, date: date, time: time, message: message);
}
