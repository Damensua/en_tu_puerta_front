import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/functions/add_seconds.dart';
import 'package:en_tu_puerta_front/functions/format_dates.dart';
import 'package:en_tu_puerta_front/functions/shorten_days.dart';
import 'package:en_tu_puerta_front/models/petition.dart';
import 'package:en_tu_puerta_front/models/service.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:en_tu_puerta_front/widget_client/search_components/days_widget.dart';
import 'package:en_tu_puerta_front/widgets/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/APIs/schedule_information.dart';
import 'package:logger/logger.dart';

final mensajero = Logger();

// Diálogo para solicitar un servicio con selección de fecha y hora
class ServiceRequestDialog extends StatefulWidget {
  const ServiceRequestDialog({super.key, required this.service});
  final Service service;

  @override
  // ignore: library_private_types_in_public_api
  _ServiceRequestDialogState createState() => _ServiceRequestDialogState();
}

class _ServiceRequestDialogState extends State<ServiceRequestDialog> {
  //Datos de autentificación para mandar la solicitud de Servicio
  String? token = globalToken;
  String? idClient = globalIdUser;
  int? idService;

  //Datos de selección del usuario
  int indexSelectedDay = -1;
  String? selectedDay;
  String? selectedTime;

  //Controller para el cambio de texto en la sección de comentario
  final TextEditingController _controller = TextEditingController();

  // Variables globales para almacenar la selección de fecha y hora

  //Fechas completas YYYY-MM-DD
  List<dynamic> dates = [];

  //Días correspondientes a las fechas
  List<dynamic> days = [];

  // Horarios disponibles para cada fecha
  Map<String, dynamic> times = {};

  // Cantidad de días a mostrar en la lista
  bool isLoading = true;
  int daysShown = 0;

  // Días en formato Lun, Mar
  List<dynamic> shortDays = [];

  // Fechas en formato DD/MM
  List<dynamic> shortDates = [];

  //inicializa el id service con el service del parametro
  @override
  void initState() {
    super.initState();
    idService = widget.service.id;

    // Fetch schedule information
    fetchScheduleInformation();
  }

  Future<void> fetchScheduleInformation() async {
    ScheduleInformation info = ScheduleInformation(idService, token);

    await info.getInfo(idService.toString(), token!);

    dates = info.getDates();
    days = info.getDays();
    times = info.getAvailableSlots();
    daysShown = info.getDaysShown();
    isLoading = false;

    mensajero.log(Level.warning,dates);
    mensajero.log(Level.warning, days);
    mensajero.log(Level.info, daysShown);
    // Initialize shortDays and shortDates after fetching data
    shortDays = shortenDays(days);
    shortDates = formatDates(dates);

    //mensajero.log(Level.warning,shortDays);
    //mensajero.log(Level.warning, shortDates);

    // Update the state to reflect the new data
    setState(() {});
  }

  // Obtiene el texto ingresado por el usuario
  String getInput() {
    String inputText = _controller.text;
    return inputText;
  }

  //
  void handleDaySelected(int index) {
    setState(() {
      indexSelectedDay = index; // Update the selected day index
    });
    //print("Selected Day Index: $indexSelectedDay");
  }

  //
  void resetDropdown() {
    setState(() {
      selectedTime = null; // Reinicia el valor seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //CONTENIDO DEL WIDGET
      content: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Solicitud de servicio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              

              // Check if daysShown is 0
              if (isLoading) ...[
              Center(child: CircularProgressIndicator()),
            ] else if (daysShown == 0 || days.isEmpty || times.isEmpty) ...[
                Text(

                  //ACA SE DEBE COLOCAR UNA IMAGEN CON UN ICONO PARA ACOMPAÑAR AL TEXTO, ICONO EN ROJO
                  //SI ESTO SUCEDE NO DEBERÍAS MOSTRARSE LOS BOTONES 
                  'Lo sentimos, no hay fechas disponibles para el servicio. Intenta en otro momento o con otro servicio.',
                  style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
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
                        resetDropdown: resetDropdown)),

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
              ],
            ]),
      ),

      //ACCION DEL WIDGET
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Quitar este boton


            //ESTOS BOTONES SOLO PUEDEN APARECER EN PANTALLA SI isLoading==FALSE && DAYSSHOWN!=0
            //BOTON PARA ENVIAR LA SOLICITUD
            ReusableButton(
              text: 'Enviar Solicitud',
              color: Color(0xFF001563),
              onPressed: () async {
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
                } else if (indexSelectedDay >= 0 && idClient != null) {
                  try {
                    Petition newPetition = Petition(
                        idUser: int.parse(idClient as String),
                        date: dates[indexSelectedDay],
                        time: addSeconds(selectedTime),
                        message: getInput(),
                        idService: idService);

                    mensajero.log(Level.info, newPetition.toJson());

                    String? response;
                    //FUNCION QUE MANDA LA PETICION A LA BASE DE DATOS
                    //response= await createPetition(newPetition.toJson(), token);
                    //mensajero.log(Level.info, response);

                    //SI REPONSE DISTINTO DE NULL SE ENVIO EXITOSAMENTE LA CUESTION
                    //Si se envia existosamente entonces sale el mensaje de besito y luego lo dejas en la pantalla detallada del servicio
                    if (response != null) {
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
                    } else {
                      //DESPLEGAR MENSAJE/
                      //Despues del mensaje y del boton okay se deja al usuario en el formulario, pero el formulario reiniciado
                      print(
                          'Hubo un error con la solicitud, intente nuevamente');
                    }

                    //
                  } catch (e) {
                    //AGREGAR UN MENSAJE POP DE QUE HA HABIDO UN ERROR CON EL ENVIO: CON EL TIPO DE ERROR
                    //Y DICIENDO QUE LO VUELVA A INTENTAR
                    print(e.toString());
                  }
                }

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
