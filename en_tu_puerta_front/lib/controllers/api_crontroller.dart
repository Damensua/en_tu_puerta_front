//import 'dart:convert';
import 'dart:convert';
import 'package:en_tu_puerta_front/functions/api_endpoints.dart';
import 'package:en_tu_puerta_front/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = Logger();

Future getToken() async {
  //Url de la pagina login
  var url = Uri.http(urlBase(), 'api/login');

  //Usario de validación para hacer el login
  var body = {'email': 'ferry.camryn@example.com', 'password': 'password'};

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
Future getPetitionS(String userId, String? token) async {
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
  //Url de la pagina login
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
  //Usario de validación para hacer el login
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
  var url = Uri.http(urlBase(), 'api/v1/services', {'filter[provider]': userId});
  
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
Future getServiceOwner(String userId, String? token) async {
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
