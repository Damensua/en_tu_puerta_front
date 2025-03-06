
import 'dart:convert';

Petition petitionFromJson(String str) => Petition.fromJson(json.decode(str));

String petitionToJson(Petition data) => json.encode(data.toJson());

class Petition {
    PetitionClass petition;

    Petition({
        required this.petition,
    });

    factory Petition.fromJson(Map<String, dynamic> json) => Petition(
        petition: PetitionClass.fromJson(json["petition"]),
    );

    Map<String, dynamic> toJson() => {
        "petition": petition.toJson(),
    };
}

class PetitionClass {
    int idUser;
    String description;
    String? type;
    String? area;
    DateTime date;
    String time;
    String message;
    int idService;

    PetitionClass({
        required this.idUser,
        required this.description,
        required this.type,
        required this.area,
        required this.date,
        required this.time,
        required this.message,
        required this.idService,
    });

    factory PetitionClass.fromJson(Map<String, dynamic> json) => PetitionClass(
        idUser: json["id_user"],
        description: json["description"],
        type: json["type"],
        area: json["area"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        message: json["message"],
        idService: json["id_service"],
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "description": description,
        "type": type,
        "area": area,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "message": message,
        "id_service": idService,
    };
}
