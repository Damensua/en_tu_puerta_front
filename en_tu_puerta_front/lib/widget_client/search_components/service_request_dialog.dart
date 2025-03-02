import 'package:en_tu_puerta_front/widget_client/search_components/location_dialog.dart';
import 'package:en_tu_puerta_front/widgets/reusable_button.dart';
import 'package:flutter/material.dart';

// Diálogo para solicitar un servicio con selección de fecha y hora
class ServiceRequestDialog extends StatefulWidget {
  const ServiceRequestDialog({super.key});

  @override
  _ServiceRequestDialogState createState() => _ServiceRequestDialogState();
}

class _ServiceRequestDialogState extends State<ServiceRequestDialog> {
  String? selectedDay;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: 400, // Set desired width
        height: 400, // Set desired height
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Solicitud de servicio',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Selecciona una fecha',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DayBox('Lun', selectedDay == 'Lun', () {
                      setState(() {
                        selectedDay = 'Lun';
                      });
                    }),
                    SizedBox(width: 10), // Space between boxes
                    DayBox('Mar', selectedDay == 'Mar', () {
                      setState(() {
                        selectedDay = 'Mar';
                      });
                    }),
                    SizedBox(width: 10), // Space between boxes
                    DayBox('Mié', selectedDay == 'Mié', () {
                      setState(() {
                        selectedDay = 'Mié';
                      });
                    }),
                    SizedBox(width: 10), // Space between boxes
                    DayBox('Jue', selectedDay == 'Jue', () {
                      setState(() {
                        selectedDay = 'Jue';
                      });
                    }),
                    SizedBox(width: 10), // Space between boxes
                    DayBox('Vie', selectedDay == 'Vie', () {
                      setState(() {
                        selectedDay = 'Vie';
                      });
                    }),
                    SizedBox(width: 10), // Space between boxes
                    DayBox('Sáb', selectedDay == 'Sáb', () {
                      setState(() {
                        selectedDay = 'Sáb';
                      });
                    }),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add some space
              Text(
                'Seleccionar hora', // New label
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedTime,
                hint: Text('Selecciona una hora'),
                items: <String>['10:00', '12:00', '14:00', '16:00', '18:00', '20:00']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedTime = newValue;
                  });
                },
              ),
              SizedBox(height: 20), // Add some space
              Text(
                'Comentarios', // New label
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              TextField(
                maxLines: 4, // Allow for multiple lines
                decoration: InputDecoration(
                  hintText: '¿Algo que te gustaría decirnos?',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ReusableButton(
              text: 'Continuar',
              color: Color(0xFF001563),
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => LocationDialog(),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

// Widget auxiliar para mostrar cajas de selección de día
Widget DayBox(String day, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 60, // Increased width for better appearance
      height: 60, // Increased height for better appearance
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(12), // More rounded corners
        color: isSelected ? Colors.blue.withOpacity(0.3) : Colors.transparent,
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 5)]
            : [],
      ),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: 18, // Increased font size for better visibility
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
      ),
    ),
  );
}
