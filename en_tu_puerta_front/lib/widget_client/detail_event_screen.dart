// lib/screens/event_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/event.dart';

class DetailEventClientScreen extends StatelessWidget {
  final Event event;

  DetailEventClientScreen({
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Proveedor ID: ${event.provider_id}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Cliente ID: ${event.client_id}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Servicio ID: ${event.service_id}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Estado: ${event.status}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Fecha: ${event.date.toLocal().toString().split(' ')[0]}',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Hora: ${event.time}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
