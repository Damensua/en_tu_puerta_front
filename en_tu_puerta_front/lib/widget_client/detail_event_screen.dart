// lib/screens/event_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/event.dart';

class DetailEventClientScreen extends StatelessWidget {
  final Event event;

  const DetailEventClientScreen({
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
        padding: const EdgeInsets.all(2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                'https://i.postimg.cc/qMDRGXkk/Notes-bro.png',
                height: 300,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Evento:',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text(event.title, style: TextStyle(fontSize: 20)),
                    SizedBox(height: 16),
                    Text('Fecha:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(event.date.toLocal().toString().split(' ')[0],
                        style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Text('Hora:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(event.time, style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Text('Estado',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Estado',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(event.status, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
