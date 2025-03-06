// To parse this JSON data, do
//
//     final service = serviceFromJson(jsonString);

import 'dart:convert';

Service serviceFromJson(String str) => Service.fromJson(json.decode(str));

String serviceToJson(Service data) => json.encode(data.toJson());

class Service {
    String type;
    int id;
    Attributes attributes;
    Relationships relationships;
    List<Link> links;

    Service({
        required this.type,
        required this.id,
        required this.attributes,
        required this.relationships,
        required this.links,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        type: json["type"],
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
        relationships: Relationships.fromJson(json["relationships"]),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "attributes": attributes.toJson(),
        "relationships": relationships.toJson(),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class Attributes {
    int idProvider;
    String serviceName;
    double servicePrice;
    String imagesPath;

    Attributes({
        required this.idProvider,
        required this.serviceName,
        required this.servicePrice,
        required this.imagesPath,
    });

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        idProvider: json["id_provider"],
        serviceName: json["service_name"],
        servicePrice: json["service_price"]?.toDouble(),
        imagesPath: json["images_path"],
    );

    Map<String, dynamic> toJson() => {
        "id_provider": idProvider,
        "service_name": serviceName,
        "service_price": servicePrice,
        "images_path": imagesPath,
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
    Provider provider;

    Relationships({
        required this.provider,
    });

    factory Relationships.fromJson(Map<String, dynamic> json) => Relationships(
        provider: Provider.fromJson(json["provider"]),
    );

    Map<String, dynamic> toJson() => {
        "provider": provider.toJson(),
    };
}

class Provider {
    Data data;
    List<Link> links;

    Provider({
        required this.data,
        required this.links,
    });

    factory Provider.fromJson(Map<String, dynamic> json) => Provider(
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
