class Service {
  final int id;
  final String firstNameProvider;
  final String lastNameProvider;
  final double punctuationProvider;
  final String addressProvider;
  final String serviceName;
  final double servicePrice;
  final String imagesPath;
  final String description;
  final int duration;

  Service({
    required this.id,
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
    return Service(
      id: json['id'],
      firstNameProvider: attributes['firstName_provider'],
      lastNameProvider: attributes['lastName_provider'],
      punctuationProvider: attributes['punctuation_provider'].toDouble(),
      addressProvider: attributes['address_provider'],
      serviceName: attributes['service_name'],
      servicePrice: attributes['service_price'].toDouble(),
      imagesPath: attributes['images_path'].replaceAll('"', ''), // Remove quotes
      description: attributes['description'],
      duration: attributes['duration'],
    );
  }
}