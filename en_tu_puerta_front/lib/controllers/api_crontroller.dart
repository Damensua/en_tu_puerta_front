import 'dart:convert';
import 'package:en_tu_puerta_front/functions/api_endpoints.dart';
import 'package:en_tu_puerta_front/models/auth_response.dart';
import 'package:en_tu_puerta_front/models/petition.dart';
import 'package:en_tu_puerta_front/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = Logger();

Future getToken(String userType) async {
  //Url de la pagina login
  var url = Uri.http(urlBase(), 'api/login');
  var body;

  //Usario de validación para hacer el login
  if (userType == 'client') {
    body = {'email': 'testcliente@example.com', 'password': 'password'};
  } else if (userType == 'provider') {
    body = {'email': 'testprestador1@example.com', 'password': 'password'};
  }

  try {
    //Envio de la información a la página, donde retorna el token para poder llamar a las demás APIs
    var response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: body,
    );

    logger.log(Level.info, 'Response status: ${response.statusCode}');
    logger.log(Level.info, 'Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      logger.log(Level.info, data);

      AuthResponse authResponse = AuthResponse.fromJson(data);

      return authResponse;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

//Controller que retorna los servcios
Future getServices(String inputSearchBar, String? token) async {
  var url = Uri.http(
      urlBase(), 'api/v1/services', {'filter[name]': '*$inputSearchBar*'});

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //logger.log(Level.info, data);

      return data;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

//Retorna un usuario con el idUser
Future getUser(String idUser, String? token) async {
  var url = Uri.http(urlBase(), 'api/v1/users/$idUser');

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);
    logger.log(Level.info, response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      logger.log(Level.info, data);

      return data;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

//Retorna una el JSON con los usuarios que tengan concidencia parcial con el input colocado
Future getUsers(String inputSearchBar, String? token) async {
  var url = Uri.http(urlBase(), 'api/v1/users', {'fullname': inputSearchBar});

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);
    //logger.log(Level.info, response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      logger.log(Level.info, data);

      return data;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

//Controller para las las solicitud de peticiones
Future getPetitionsByIdUser(String? userId, String? token) async {
  var url = Uri.http(urlBase(), 'api/v1/petitions',
      {'filter[provider]': '$userId & include=user'});

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['data'] != null) {
        List<dynamic> petitionsData = jsonResponse['data'];
        return petitionsData
            .map((petition) => Petition.fromJson(petition))
            .toList();
      }
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

//Controller para solicitar las fechas y horas disponibles para los servicios
Future serviceSchedule(String serviceId, String? token) async {
  var url = Uri.http(urlBase(), 'api/v1/petitions/create/$serviceId');

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      //logger.log(Level.info, data);

      return data;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

//Controller para enviar una solicitud de servicio al backend
Future postPetition(Map<String, dynamic> petitionJson, String? token) async {
  var url = Uri.http(urlBase(), 'api/v1/petitions');

  Map<String, String>? header;
  if (token != null) {
    header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  } else {
    header = {'Accept': 'application/json', 'Content-Type': 'application/json'};
  }
  //Usuario de validación para hacer el login
  var body = jsonEncode(petitionJson);
  logger.log(Level.debug, body);

  try {
    //Envio de la información a la página, donde retorna el token para poder llamar a las demás APIs
    var response = await http.post(
      url,
      headers: header,
      body: body,
    );

    logger.log(Level.info, 'Response status: ${response.statusCode}');
    //logger.log(Level.info, 'Response body: ${response.body}');

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);

      logger.log(Level.info, data);

      return response.statusCode;
    } else if (response.statusCode == 409) {
      var data = jsonDecode(response.body);

      logger.log(Level.info, data);

      return response.statusCode;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
    return null;
  }
}

//Controller para traer los servicios de un prestador
Future getOwnServices(int userId, String? token) async {
  var url =
      Uri.http(urlBase(), 'api/v1/services', {'filter[provider]': '$userId'});

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);
    //logger.log(Level.info, response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      logger.log(Level.info, data);

      return data;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

//Controller para buscar la información de un prestador
Future getServiceOwner(int userId, String? token) async {
  var url = Uri.http(urlBase(), 'api/v1/users/$userId');

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);
    //logger.log(Level.info, response.statusCode);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      logger.log(Level.info, data);

      return data;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

Future getEventsByUser(String? userId, String? token, bool? client) async {
  var url;
  if (client == true) {
     url = Uri.http(urlBase(), 'api/v1/events',
        {'filter[client]': '$userId & include=client'});
  } else {
    url = Uri.http(urlBase(), 'api/v1/events',
        {'filter[provider]': '$userId & include=provider'});
  }

  Map<String, String>? header;

  if (token != null) {
    header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
  } else {
    header = {'Accept': 'application/json'};
  }

  try {
    var response = await http.get(url, headers: header);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      // Verifica si la respuesta es un mapa y extrae la lista de eventos
      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse['data'] != null) {
        List<dynamic> eventsData = jsonResponse['data'];
        return eventsData.map((event) => Event.fromJson(event)).toList();
      } else {
        throw Exception('Formato de respuesta inesperado');
      }
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
    return [];
  }
}

Future<dynamic> createEvent(Event event, String? token) async {
  var url = Uri.http(urlBase(), 'api/v1/events');
  var body = event.toJson();

  print("Request body: ${jsonEncode(body)}");

  Map<String, String>? header;

  if (token != null) {
    header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  } else {
    header = {'Accept': 'application/json', 'Content-Type': 'application/json'};
  }

  try {
    var response = await http.post(
      url,
      headers: header,
      body: jsonEncode(body), // Asegúrate de codificar el cuerpo como JSON
    );

    if (response.statusCode == 201) {
      return response;
    } else if (response.statusCode == 409) {
      return response;
    } else {
      // Puedes lanzar una excepción o devolver null
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
    return null;
  }
}

//Controller para aceptar una solicitud de servicio
Future acceptPetition(Petition petition, String? token) async {
  var petitionId = petition.id;
  var url = Uri.http(urlBase(), 'api/v1/petitions/$petitionId');

  Map<String, String>? header;
  if (token != null) {
    header = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  } else {
    header = {'Accept': 'application/json', 'Content-Type': 'application/json'};
  }

  //Usuario de validación para hacer el login
  var body = jsonEncode(petition.toJson());
  print('VER ESTO ACA              $body');

  try {
    //Envio de la información a la página, donde retorna el token para poder llamar a las demás APIs
    var response = await http.patch(
      url,
      headers: header,
      body: body,
    );

    logger.log(Level.info, 'Response status: ${response.statusCode}');
    logger.log(Level.info, 'Response body: ${response.body}');

    if (response.statusCode == 201) {
      var data = jsonDecode(response.body);

      logger.log(Level.info, data);

      return response.statusCode;
    } else if (response.statusCode == 409) {
      var data = jsonDecode(response.body);

      logger.log(Level.info, data);

      return response.statusCode;
    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
    return null;
  }
}
