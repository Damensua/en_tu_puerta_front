import 'dart:convert';

class Service {
  final int id;
  final int idProvider;
  final String firstNameProvider;
  final String lastNameProvider;
  final double punctuationProvider;
  final String addressProvider;
  final String serviceName;
  final double servicePrice;
  final List<String> imagesPath;
  final String description;
  final int duration;

  Service({
    required this.id,
    required this.idProvider,
    required this.firstNameProvider,
    required this.lastNameProvider,
    required this.punctuationProvider,
    required this.addressProvider,
    required this.serviceName,
    required this.servicePrice,
    required this.imagesPath,
    required this.description,
    required this.duration,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];

    List<String> imagesPath = [];

    if (attributes.containsKey('images_path') &&
        attributes['images_path'] != null) {
      if (attributes['images_path'] is String) {
        try {
          imagesPath = List<String>.from(jsonDecode(attributes['images_path']));
        } catch (e) {
          print("Error decoding images_path: $e");
          // If decoding fails, log the error and proceed with an empty list or handle as needed
        }
      }
      // Check if images_path is already a List
      else if (attributes['images_path'] is List) {
        imagesPath = List<String>.from(attributes['images_path']);
      } else {
        print("images_path is not String or List");
      }
    }

    return Service(
      id: json['id'],
      idProvider: attributes["id_provider"],
      firstNameProvider: attributes['firstName_provider'],
      lastNameProvider: attributes['lastName_provider'],
      punctuationProvider: attributes['punctuation_provider'].toDouble(),
      addressProvider: attributes['address_provider'],
      serviceName: attributes['service_name'],
      servicePrice: attributes['service_price'].toDouble(),
      imagesPath: imagesPath,
      description: attributes['description'],
      duration: attributes['duration'],
    );
  }
}
