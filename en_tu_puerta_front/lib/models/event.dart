class Event {
  final int provider_id;
  final int client_id;
  final int service_id;
  final String status;
  final DateTime date;
  final String time;

  Event({
    required this.provider_id,
    required this.client_id,
    required this.service_id,
    required this.status,
    required this.date,
    required this.time,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return Event(
      provider_id: attributes['provider_id'],
      client_id: attributes['client_id'],
      service_id: attributes['service_id'],
      status: attributes['status'],
      date: DateTime.parse(attributes['date']),
      time: attributes['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "attributes": {
          "provider_id": provider_id,
          "client_id": client_id,
          "service_id": service_id,
          "date": date.toIso8601String(),
          "time": time,
        }
      }
    };
  }
}
