import 'package:en_tu_puerta_front/functions/format_dates.dart';
import 'package:en_tu_puerta_front/functions/shorten_days.dart';
import 'package:en_tu_puerta_front/models/petition.dart';
import 'package:en_tu_puerta_front/widget_client/search_components/days_widget.dart';
import 'package:en_tu_puerta_front/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/APIs/info.dart';

final info = Info();
// Variables globales para almacenar la selección de fecha y hora

//Fechas completas YYYY-MM-DD
List<dynamic> dates = info.getDates();

//Días correspondientes a las fechas
List<dynamic> days = info.getDays();

// Horarios disponibles para cada fecha
Map<String, dynamic> times = info.getAvailableSlots();

// Cantidad de días a mostrar en la lista
int daysShown = info.getDaysShown();

//Días en formato Lun, Mar
List shortDays = shortenDays(days);

//Fechas en formato DD/MM
List shortDates = formatDates(dates);

// Diálogo para solicitar un servicio con selección de fecha y hora
class ServiceRequestDialog extends StatefulWidget {
  const ServiceRequestDialog({super.key});

  @override
  _ServiceRequestDialogState createState() => _ServiceRequestDialogState();
}






class _ServiceRequestDialogState extends State<ServiceRequestDialog> {
  int indexSelectedDay = -1;
  String? selectedDay;
  String? selectedTime;

  final TextEditingController _controller = TextEditingController();

  String getInput() {
    String inputText = _controller.text;
    return inputText; // Handle the input as needed
  }

  void handleDaySelected(int index) {
    setState(() {
      indexSelectedDay = index; // Update the selected day index
    });
    //print("Selected Day Index: $indexSelectedDay");
  }
  
  void resetDropdown() {
      setState(() {
        selectedTime = null; // Reinicia el valor seleccionado
      });
    }
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

              //TEXTO SELECCIONA UNA FECHA
              Text(
                'Selecciona el día',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),

              //FECHAS DISPONIBLES
              SizedBox(
                  height: 150,
                  child: DaysWidget(
                      daysShown: daysShown,
                      days: shortDays,
                      date: shortDates,
                      onDaySelected: handleDaySelected,
                      resetDropdown:resetDropdown)),

              //DROPDOWN DE HORARIOS DISPONIBLES
              SizedBox(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  // Dropdown for hours
                  if (indexSelectedDay >= 0)
                    (DropdownButton<String>(
                        hint: Text('Selecciona la hora'),
                        value: selectedTime,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTime = newValue;
                            print(selectedTime);
                          });
                        },
                        items: (indexSelectedDay >= 0 &&
                                indexSelectedDay < dates.length &&
                                times.containsKey(dates[indexSelectedDay]) &&
                                times[dates[indexSelectedDay]] != null &&
                                times[dates[indexSelectedDay]]!.isNotEmpty)
                            ? (times[dates[indexSelectedDay]] as List<String>)
                                .map<DropdownMenuItem<String>>((String hour) {
                                return DropdownMenuItem<String>(
                                  value: hour,
                                  child: Text(hour),
                                );
                              }).toList()
                            : []))
                ],
              )),

              //CAJA DE TEXTO
              SizedBox(
                child: TextField(
                  maxLength: 250,
                  minLines: 1,
                  maxLines: null, //
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Comentarios',
                  ),
                ),
              ),
            ]),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Quitar este boton
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),

            //BOTON PARA ENVIAR LA SOLICITUD
            ReusableButton(
              text: 'Enviar Solicitud',
              color: Color(0xFF001563),
              onPressed: () {
                if (indexSelectedDay == -1) {
                  //No se ha seleccionado ningun día entonces no se puede enviar la petición
                  // y hay que colocar una advertencia
                  print(
                      "Debe seleccionar una fecha para solicitar el servicio");
                } else if (selectedTime == null) {
                  //No se ha seleccionado ningun horario entonces no se puede enviar la petición
                  // y hay que colocar una advertencia
                  print(
                      "Debe seleccionar un horario para solicitar el servicio");

                  //Procede a intentar crear la solicitud
                } else if (indexSelectedDay >= 0) {
                  try {
                    // Petition newPetition = Petition(
                    //     day: days[indexSelectedDay],
                    //     date: dates[indexSelectedDay],
                    //     time: selectedTime,
                    //     message: getInput());
                    // print(newPetition.toString());
                    
                    
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Solicitud enviada!'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                'El proveedor de servicio responderá en los próximos 10 minutos para confirmar la solicitud'),
                            SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              child: ReusableButton(
                                text: 'Aceptar',
                                color: Color(0xFF001563),
                                onPressed: () {
                                  // Cierra todos los diálogos y regresa a la pantalla principal
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    
                  } catch (e) {
                    print(e.toString());
                  }
                }

                //AQUI VA EL CODIGO QUE CREA EL OBJETO SOLICITUD Y LO ENVIA A LA BASE DE DATOS
                // Ejemplo:
                // Solicitud solicitud = Solicitud(
                //   fecha: dates[indexSelectedDay],
                //   hora: selectedTime,
                //   comentarios: widget.commentText,
                //   // Añadir más campos según sea necesario
                // );
                // await solicitud.save();
                // print('Solicitud guardada con éxito');

                // Simulación de envío de solicitud
                // Aquí podría ser llamado un API para enviar la solicitud al proveedor de servicio
                // Ejemplo:
                // await info.sendServiceRequest(solicitud);
                // print('Solicitud enviada al proveedor de servicio');

                // Mostrar diálogo de confirmación
                // Aquí podría ser utilizado un framework de diálogos, como Flutter Dialogs,
              },
            ),
          ],
        ),
      ],
    );
  }
}
