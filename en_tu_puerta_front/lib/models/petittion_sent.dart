

import 'dart:convert';

PetitionSent petitionSentFromJson(String str) => PetitionSent.fromJson(json.decode(str));

String petitionSentToJson(PetitionSent data) => json.encode(data.toJson());

class PetitionSent {
    String type;
    int id;
    PetitionSentAttributes attributes;
    Relationships relationships;
    Includes includes;
    List<Link> links;

    PetitionSent({
        required this.type,
        required this.id,
        required this.attributes,
        required this.relationships,
        required this.includes,
        required this.links,
    });

    factory PetitionSent.fromJson(Map<String, dynamic> json) => PetitionSent(
        type: json["type"],
        id: json["id"],
        attributes: PetitionSentAttributes.fromJson(json["attributes"]),
        relationships: Relationships.fromJson(json["relationships"]),
        includes: Includes.fromJson(json["includes"]),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
        "includes": includes.toJson(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class PetitionSentAttributes {
    int idUser;
    String description;
    String type;
    DateTime date;
    String time;
    String status;
    String message;
    int idService;
    DateTime createdAt;

    PetitionSentAttributes({
        required this.idUser,
        required this.description,
        required this.type,
        required this.date,
        required this.time,
        required this.status,
        required this.message,
        required this.idService,
        required this.createdAt,
    });

    factory PetitionSentAttributes.fromJson(Map<String, dynamic> json) => PetitionSentAttributes(
        idUser: json["id_user"],
        description: json["description"],
        type: json["type"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        status: json["status"],
        message: json["message"],
        idService: json["id_service"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "description": description,
        "type": type,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "status": status,
        "message": message,
        "id_service": idService,
        "created_at": createdAt.toIso8601String(),
    };
}

class Includes {
    String type;
    int id;
    IncludesAttributes attributes;

    Includes({
        required this.type,
        required this.id,
        required this.attributes,
    });

    factory Includes.fromJson(Map<String, dynamic> json) => Includes(
        type: json["type"],
        id: json["id"],
        attributes: IncludesAttributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
    };
}

class IncludesAttributes {
    String firstName;
    String lastName;
    String username;
    String email;
    String address;

    IncludesAttributes({
        required this.firstName,
        required this.lastName,
        required this.username,
        required this.email,
        required this.address,
    });

    factory IncludesAttributes.fromJson(Map<String, dynamic> json) => IncludesAttributes(
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "address": address,
    };
}

class Link {
    String self;

    Link({
        required this.self,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        self: json["self"],
    );

    Map<String, dynamic> toJson() => {
        "self": self,
    };
}

class Relationships {
    Client client;
    Service service;

    Relationships({
        required this.client,
        required this.service,
    });

    factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        client: Client.fromJson(json["client"]),
        service: Service.fromJson(json["service"]),
    );

    Map<String, dynamic> toJson() => {
        "client": client.toJson(),
        "service": service.toJson(),
    };
}

class Client {
    Data data;
    List<Link> links;

    Client({
        required this.data,
        required this.links,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        data: Data.fromJson(json["data"]),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class Data {
    String type;
    int id;

    Data({
        required this.type,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
    };
}

class Service {
    Data data;
    Link links;

    Service({
        required this.data,
        required this.links,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        data: Data.fromJson(json["data"]),
        links: Link.fromJson(json["links"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "links": links.toJson(),
    };
}
