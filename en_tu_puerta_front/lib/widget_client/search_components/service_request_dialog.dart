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
      content: SingleChildScrollView(
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
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DayBox('Lun', selectedDay == 'Lun', () {
                    setState(() {
                      selectedDay = 'Lun';
                    });
                  }),
                  DayBox('Mar', selectedDay == 'Mar', () {
                    setState(() {
                      selectedDay = 'Mar';
                    });
                  }),
                  DayBox('Mié', selectedDay == 'Mié', () {
                    setState(() {
                      selectedDay = 'Mié';
                    });
                  }),
                  DayBox('Jue', selectedDay == 'Jue', () {
                    setState(() {
                      selectedDay = 'Jue';
                    });
                  }),
                  DayBox('Vie', selectedDay == 'Vie', () {
                    setState(() {
                      selectedDay = 'Vie';
                    });
                  }),
                  DayBox('Sáb', selectedDay == 'Sáb', () {
                    setState(() {
                      selectedDay = 'Sáb';
                    });
                  }),
                ],
              ),
            ),
            DropdownButton<String>(
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

          ],
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
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
      ),
      child: Center(
        child: Text(day),
      ),
    ),
  );
}

// Widget auxiliar para mostrar cajas de selección de hora
Widget TimeComp(String time, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.transparent,
      ),
      child: Center(
        child: Text(time),
      ),
    ),
  );
}
