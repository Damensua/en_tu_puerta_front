/**Función que retorna una lista con las fechas en el formato dd/mm
 * el argumento es una lista con las fechas que se quieren formatear 
 * */
///
List<dynamic> formatDates(dates) {
  return dates.map((date) {
    List<String> parts = date.split("-");

    String day = parts[2]; 
    String month = parts[1]; 
    
    return '$day/$month';
  }).toList();
}


