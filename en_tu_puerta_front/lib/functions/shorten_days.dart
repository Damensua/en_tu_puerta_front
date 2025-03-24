/**Función que retorna una lista con las primeras tres letras de cada día 
 * con la primera letra en mayúsucla 
 * el argumento es una lista con los días que se quieren abreviar 
 * */
///
List<dynamic> shortenDays(days) {
  return days.map((day) {
    
    String shortened = day.length > 3 ? day.substring(0, 3) : day;
    return shortened[0].toUpperCase() + shortened.substring(1).toLowerCase();
  }).toList();
}
