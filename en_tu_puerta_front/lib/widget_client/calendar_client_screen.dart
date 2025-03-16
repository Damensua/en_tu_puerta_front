import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/functions/read_data.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event.dart';
import 'package:logger/logger.dart';
import 'dart:collection';
import 'detail_event_screen.dart';

final logger = Logger();

class WidgetCalendar extends StatefulWidget {
  const WidgetCalendar({super.key});

  @override
  State<WidgetCalendar> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<WidgetCalendar> {
//Token//
  String? localToken = globalToken;
  String? userId = globalIdUser;

  //Lista de objetos Evento y usuario//
  List eventsFounds = [];
  List usersFounds = [];

  late LinkedHashMap<DateTime, List<Event>> events;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  //final int userId = 1; // Cambia esto según el usuario actual

  //TODO: Como tomo el id del usuario que di con el token?

  @override
  void initState() {
    super.initState();
    events = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    _loadEvents();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  Future<void> _loadEvents() async {
    List<Event> fetchedEvents = await getEventsByUser(userId, localToken);

    setState(() {
      for (var eventMap in fetchedEvents) {
        if (events[eventMap.date] == null) {
          events[eventMap.date] = [];
        }
        events[eventMap.date]!.add(eventMap);
      }
    });
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) => _getEventsForDay(day),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _getEventsForDay(_selectedDay).isEmpty
                ? Center(
                    child: Text('No tiene eventos agendados para este día.'),
                  )
                : ListView(
                    children: _getEventsForDay(_selectedDay).map((event) {
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text('Evento: ${event.status}'),
                          subtitle: Text(
                              'Fecha: ${event.date.toLocal().toString().split(' ')[0]} - Hora: ${event.time}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailEventClientScreen(event: event),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
