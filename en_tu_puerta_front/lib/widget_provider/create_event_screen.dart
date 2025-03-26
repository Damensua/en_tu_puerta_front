import 'package:en_tu_puerta_front/widgets/reusable_button.dart';
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
  String? localToken = globalProviderToken;
  String? userId = globalIdProvider;

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
        if (response.statusCode == 201) {
          // Manejar la respuesta, por ejemplo, mostrar un mensaje de éxito
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Evento creado con éxito')),
          );
          _resetFields();
        } else if (response.statusCode == 409) {
          // Manejar la respuesta, por ejemplo, mostrar un mensaje de éxito
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body)),
          );
          Navigator.pop(context); // Cierra la pantalla de creación
        } else {
          // Manejar el error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.body)),
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

  void _resetFields() {
    setState(() {
      _titleController.clear(); // Limpia el texto del título
      _selectedDate = null; // Resetea la fecha seleccionada
      _selectedTime = null; // Resetea la hora seleccionada
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
        Image.network(
          'https://i.postimg.cc/Z59qsBR6/Timeline-bro.png',
          height: 200,
        ),
        SizedBox(height: 20),
        Text(
          'Crear evento',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF001563),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Título del evento',
            labelStyle: TextStyle(color: Color(0xFF001563)),
          ),
        ),
        SizedBox(height: 25),
        Align(  
          alignment: Alignment.centerLeft,
          child: Text(
            'Selecione los datos:',
            style: TextStyle(
              fontSize: 16, // Tamaño de la fuente
              color: Color(0xFF001563), // Color del texto
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
          child: ReusableButton(
            onPressed: () => _selectDate(context),
            text: _selectedDate == null
            ? 'Fecha'
            : DateFormat('yyyy-MM-dd').format(_selectedDate!),
            color: Color(0xFF001563),
          ),
            ),
            SizedBox(width: 10), 
            Expanded(
            child: ReusableButton(
            onPressed: () => _selectTime(context),
            text: _selectedTime == null
            ? 'Hora'
            : _selectedTime!,
            color: Color(0xFF001563),
            ),
            ),
          ],
        ),
        SizedBox(height: 180),
        SizedBox(
          width: 200, 
          child: ReusableButton(
            onPressed: _createEvent,
            text: 'Crear evento',
            color: Color(0xFF001563),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
