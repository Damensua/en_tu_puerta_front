/**Función que retorna una lista con las fechas en el formato dd/mm
 * el argumento es una lista con las fechas que se quieren formatear 
 * */
///
List<dynamic> formatDates(dates) {
  return dates.map((date) {
    // Split the date string by "-"
    List<String> parts = date.split("-");
    // Extract day and month
    String day = parts[2]; // Day is the third part
    String month = parts[1]; // Month is the second part
    // Return formatted string
    return '$day/$month';
  }).toList();
}


