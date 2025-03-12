class Petition {
  final int idUser ;
  final String date;
  final String? time;
  final String message;
  final int? idService;

  Petition({
    required this.idUser ,
    required this.date,
    required this.time,
    required this.message,
    required this.idService,
  });

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "data": {
        "attributes": {
          "id_user": idUser ,
          "date": date,
          "time": time,
          "message": message,
          "id_service": idService,
        }
      }
    };
  }
}