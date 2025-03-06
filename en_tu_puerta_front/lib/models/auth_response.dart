import 'dart:convert';

class AuthResponse {
  String token;
  String message;
  int status;

  // Constructor que recibe un JSON y extrae la información
  AuthResponse.fromJson(Map<String, dynamic> json)
      : token = json["data"]["token"],
        message = json["message"],
        status = json["status"];

  // Método para convertir una instancia de AuthResponse a JSON
  Map<String, dynamic> toJson() {
    return {
      "data": {
        "token": token,
      },
      "message": message,
      "status": status,
    };
  }

  // Método para obtener una representación en cadena de la clase
  @override
  String toString() {
    return 'AuthResponse: { token: $token, message: $message, status: $status }';
  }
}

// Función para convertir un JSON string a una instancia de AuthResponse
AuthResponse authResponseFromJson(String str) {
  return AuthResponse.fromJson(json.decode(str));
}

// Función para convertir una instancia de AuthResponse a un JSON string
String authResponseToJson(AuthResponse data) {
  return json.encode(data.toJson());
}