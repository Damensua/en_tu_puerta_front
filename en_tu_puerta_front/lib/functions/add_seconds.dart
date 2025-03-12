String? addSeconds(String? time) {
  //Revisa si el tiempo ingresado esta en HH:MM
  if (time!=null){
    if (RegExp(r'^\d{1,2}:\d{2}$').hasMatch(time)) {
      return '$time:00'; //Agrega ":00" 
    } else {
      return time; // Regresa el original si ya tiene el formato de HH:MM:SS
    }}
    else {
    return time; // Devuelve 00:00 si no hay un tiempo ingresado
  }
}