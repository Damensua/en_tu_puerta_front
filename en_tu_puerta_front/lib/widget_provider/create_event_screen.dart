import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:en_tu_puerta_front/models/event.dart';
import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  String? localToken = globalToken;
  String? userId = globalIdUser;

  final TextEditingController _titleController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context); // Formato de 12 horas
      });
    }
  }

  Future<void> _createEvent() async {
    if (_titleController.text.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null &&
        userId != null) {
      // Crear el evento
      Event newEvent = Event(
        provider_id: int.parse(userId!),
        client_id: null,
        service_id: null,
        title: _titleController.text,
        date: _selectedDate!,
        time: _selectedTime!,
        status: 'Pendiente',
      );

      print(newEvent);

      try {
        // Llama a la función para enviar el evento al backend
        final response = await createEvent(newEvent, localToken);

        // Verifica si la respuesta es exitosa
        if (response != null) {
          // Manejar la respuesta, por ejemplo, mostrar un mensaje de éxito
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Evento creado con éxito')),
          );
          Navigator.pop(context); // Cierra la pantalla de creación
        } else {
          // Manejar el error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al crear el evento')),
          );
        }
      } catch (e) {
        // Captura cualquier error que ocurra
        print('Error al crear el evento: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el evento: $e')),
        );
      }
    } else {
      // Manejar el caso en que alguno de los campos es nulo
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Evento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título del Evento'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text(
                _selectedDate == null
                    ? 'Seleccionar Fecha'
                    : 'Fecha: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => _selectTime(context),
              child: Text(
                _selectedTime == null
                    ? 'Seleccionar Hora'
                    : 'Hora: $_selectedTime',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createEvent,
              child: Text('Crear Evento'),
            ),
          ],
        ),
      ),
    );
  }
}
