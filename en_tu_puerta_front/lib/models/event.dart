import 'package:intl/intl.dart';

class Event {
  final int provider_id;
  final int? client_id;
  final int? service_id;
  final String title;
  final DateTime date;
  final String time;
  final String status;

  Event({
    required this.provider_id,
    required this.client_id,
    required this.service_id,
    required this.title,
    required this.date,
    required this.time,
    required this.status,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return Event(
      provider_id: attributes['provider_id'],
      client_id: attributes['client_id'],
      service_id: attributes['service_id'],
      title: attributes['title'],
      date: DateTime.parse(attributes['date']),
      time: attributes['time'],
      status: attributes['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'attributes': {
          'provider_id': provider_id,
          'title': title,
          'date': DateFormat('yyyy-MM-dd').format(date), // Formato de fecha
          'time': _convertTimeTo24HourFormat(time), // Formato de hora
        }
      }
    };
  }

  // Función para convertir la hora de formato 12 horas a 24 horas
  String _convertTimeTo24HourFormat(String time) {
    // Eliminar espacios adicionales
    time = time.trim();
    print(
        'Cadena de tiempo a convertir: "$time"'); // Imprimir la cadena de tiempo

    // Separar la hora, los minutos y el periodo (AM/PM)
    final parts = time.split(' ');
    if (parts.length != 2) {
      print('Error: formato de tiempo incorrecto');
      return time; // Devuelve la cadena original en caso de error
    }

    final timeParts = parts[0].split(':');
    if (timeParts.length != 2) {
      print('Error: formato de tiempo incorrecto');
      return time; // Devuelve la cadena original en caso de error
    }

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    String period = parts[1].toUpperCase(); // AM o PM

    // Convertir a formato 24 horas
    if (period == 'PM' && hour != 12) {
      hour += 12; // Convertir a 24 horas
    } else if (period == 'AM' && hour == 12) {
      hour = 0; // 12 AM es 00 horas
    }

    // Formatear la hora en HH:mm:ss
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:00';
  }
}
