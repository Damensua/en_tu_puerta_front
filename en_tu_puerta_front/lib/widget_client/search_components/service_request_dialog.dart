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
  late int idService;

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
    fetchScheduleInformation();
  }

  Future<void> fetchScheduleInformation() async {
    // Reinicializa las listas y variables
    dates.clear();
    days.clear();
    times.clear();
    shortDays.clear();
    shortDates.clear();
    isLoading = true;
    ScheduleInformation info = ScheduleInformation(idService, token);

    await info.getInfo(idService.toString(), token!);

    dates = info.getDates();
    days = info.getDays();
    times = info.getAvailableSlots();
    daysShown = info.getDaysShown();
    isLoading = false;

    mensajero.log(Level.warning, dates);
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
                          color: Color(0xFF001563),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Color(0xFF001563),
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
                Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.red,
                        size: 50,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Text(
                  'Lo sentimos, no hay fechas disponibles para el servicio. Intenta en otro momento o con otro servicio.',
                  style: TextStyle(
                      fontSize: 16, color: const Color.fromARGB(255, 0, 0, 0)),
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
                DaysWidget(
                    daysShown: daysShown,
                    days: shortDays,
                    date: shortDates,
                    onDaySelected: handleDaySelected,
                    resetDropdown: resetDropdown),

                //DROPDOWN DE HORARIOS DISPONIBLES
                SizedBox(height: 5),
                SizedBox(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    // Dropdown for hours
                    if (indexSelectedDay >= 0)
                      (DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Selecciona la hora',
                          ),
                          value: selectedTime,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTime = newValue;
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
                                    child: Text(
                                      hour,
                                      style: TextStyle(
                                          fontSize:
                                              16), // Customize item text style
                                    ),
                                  );
                                }).toList()
                              : []))
                  ],
                )),
                SizedBox(height: 15),

                //CAJA DE TEXTO
                SizedBox(
                  child: TextField(
                    maxLength: 250,
                    minLines: 1,
                    maxLines: null, //
                    controller: _controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF001563)),
                      ),
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //BOTON PARA ENVIAR LA SOLICITUD
            if (!isLoading && daysShown != 0)
              ReusableButton(
                text: 'Enviar Solicitud',
                color: Color(0xFF001563),
                onPressed: () async {
                  if (indexSelectedDay == -1) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text('Advertencia',
                                style: TextStyle(color: Color(0xFF001563))),
                          ],
                        ),
                        content: Text(
                            'Debe seleccionar una fecha para solicitar el servicio',
                            style: TextStyle(fontSize: 18)),
                        actions: [
                          Center(
                            child: ReusableButton(
                              text: 'Ok',
                              color: Color(0xFF001563),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (selectedTime == null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Row(
                          children: [
                            Icon(
                              Icons.warning,
                              color: Colors.red,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text('Advertencia',
                                style: TextStyle(color: Color(0xFF001563))),
                          ],
                        ),
                        content: Text(
                            'Debe seleccionar un horario para solicitar el servicio',
                            style: TextStyle(fontSize: 18)),
                        actions: [
                          Center(
                            child: ReusableButton(
                              text: 'Ok',
                              color: Color(0xFF001563),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    );

                  } else if (indexSelectedDay >= 0 && idClient != null) {
                    try {
                      Petition newPetition = Petition(
                        idUser: int.parse(idClient as String),
                        date: dates[indexSelectedDay],
                        time: addSeconds(selectedTime),
                        message: getInput(),
                        idService: idService,
                        firstNameUser: null,
                        lastNameUser: null,
                        imageUser: null,
                        status: null,
                        nameService: null,
                      );
                      mensajero.log(Level.info, newPetition.toJson());

                      String? response;
                      response =
                          await postPetition(newPetition.toJson(), token);
                      mensajero.log(Level.info, response);

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
                      } else if (response == '409') {
                        // Mostrar un mensaje emergente indicando que ya existe la solicitud
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text('Solicitud duplicada',
                                    style: TextStyle(color: Color(0xFF001563))),
                              ],
                            ),
                            content: Text(
                                'Ya existe una solicitud para este servicio en la fecha y hora seleccionadas.',
                                style: TextStyle(fontSize: 18)),
                            actions: [
                              Center(
                                child: ReusableButton(
                                  text: 'Ok',
                                  color: Color(0xFF001563),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        //DESPLEGAR MENSAJE/
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                  size: 24,
                                ),
                                SizedBox(width: 8),
                                Text('Error',
                                    style: TextStyle(color: Color(0xFF001563))),
                              ],
                            ),
                            content: Text(
                                'Hubo un error con la solicitud, intente nuevamente.',
                                style: TextStyle(fontSize: 18)),
                            actions: [
                              Center(
                                child: ReusableButton(
                                  text: 'Ok',
                                  color: Color(0xFF001563),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Reinicia el formulario
                                    setState(() {
                                      indexSelectedDay = -1;
                                      selectedDay = null;
                                      selectedTime = null;
                                      _controller.clear();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      //
                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: [
                              Icon(
                                Icons.warning,
                                color: Colors.red,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Ha ocurrido un error',
                                style: TextStyle(color: Color(0xFF001563)),
                              ),
                            ],
                          ),
                          content: Text(
                              'Intente más tarde. Detalles del error: ${e.toString()}',
                              style: TextStyle(fontSize: 18)),
                          actions: [
                            Center(
                              child: ReusableButton(
                                text: 'Ok',
                                color: Color(0xFF001563),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                      print(e.toString());
                    }
                  }

                  // Mostrar diálogo de confirmación
                  // Aquí podría ser utilizado un framework de diálogos, como Flutter Dialogs,
                },
              )
            else
              ReusableButton(
                text: 'Ok',
                color: Color(0xFF001563),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ],
    );
  }
}
