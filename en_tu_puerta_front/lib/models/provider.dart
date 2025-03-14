import 'dart:convert';

class Provider {
  final String type;
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String address;

  Provider({
    required this.type,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.address,
  });

  // Factory method to create a Provider from JSON
  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      type: json['type'],
      id: json['id'],
      firstName: json['attributes']['first_name'],
      lastName: json['attributes']['last_name'],
      username: json['attributes']['username'],
      email: json['attributes']['email'],
      address: json['attributes']['address'],
    );
  }
}

// Function to parse the JSON response
List<Provider> parseProviders(String responseBody) {
  final parsed = json.decode(responseBody)['data'].cast<Map<String, dynamic>>();
  return parsed.map<Provider>((json) => Provider.fromJson(json)).toList();
}