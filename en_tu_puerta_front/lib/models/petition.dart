class Petition {
  final int idUser;
  final String? firstNameUser;
  final String? lastNameUser;
  final String? imageUser;
  final DateTime date;
  final String? time;
  final String? status;
  final String message;
  final int? idService;
  final String? nameService;

  Petition({
    required this.idUser,
    required this.firstNameUser,
    required this.lastNameUser,
    required this.imageUser,
    required this.date,
    required this.time,
    required this.status,
    required this.message,
    required this.idService,
    required this.nameService,
  });

  factory Petition.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    return Petition(
      idUser: attributes['id_user'],
      firstNameUser: attributes['firstname_user'],
      lastNameUser: attributes['lastname_user'],
      imageUser: attributes['image_user'],
      date: DateTime.parse(attributes['date']),
      time: attributes['time'],
      status: attributes['status'],
      message: attributes['message'],
      idService: attributes['id_service'],
      nameService: attributes['name_service'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "attributes": {
          "id_user": idUser,
          "date": date,
          "time": time,
          "message": message,
          "id_service": idService,
        }
      }
    };
  }
}
