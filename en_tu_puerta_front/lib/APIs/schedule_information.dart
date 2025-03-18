//ESETA CLASE RECIBE COMO PARAMETRO DEL ID DEL PROVEEDOR PARA LUEGO LLAMAR A LA BASE DE DATOS Y TRAERME SUS COSAS
import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:logger/logger.dart';

final mensajero = Logger();

class ScheduleInformation {
  final int? serviceId;
  final String? token;

  // Atributos para almacenar la información del horario
  List<String> dates = [];
  List<String> days = [];
  Map<String, List<String>> availableSlotsMap = {};
  int daysShown = 0;

  ScheduleInformation(this.serviceId, this.token);

  Future<void> getInfo(String serviceId, String token) async {
    // Limpia los datos antes de realizar la llamada a la API
    dates.clear();
    days.clear();
    availableSlotsMap.clear();
    daysShown = 0;

    
    try {
      // Llamada a la API
      var data = await serviceSchedule(serviceId, token);

      mensajero.log(Level.info, data);
      // Verifica que la respuesta contenga datos
      if (data != null && data.isNotEmpty) {
        for (var entry in data) {
          // Agregar fecha y día a sus respectivas listas
          if (entry["available_slots"] != null &&
              entry["available_slots"].isNotEmpty) {
            dates.add(entry["date"]);
            days.add(entry["day"]);

            // Agregar fecha y horarios disponibles al mapa
            availableSlotsMap[entry["date"]] =
                List<String>.from(entry["available_slots"]);
          }
        }
        daysShown = days.length;

      } else {
        mensajero.log(Level.warning, "No se recibieron datos de la API.");
      }
    } catch (e) {
      mensajero.log(Level.error, "Error al obtener información: $e");
    }
  }

  // Métodos para obtener la información
  List<String> getDays() => days;
  List<String> getDates() => dates;
  int getDaysShown() => daysShown;
  Map<String, List<String>> getAvailableSlots() => availableSlotsMap;
}