//import 'dart:convert';
import 'dart:convert';
import 'package:en_tu_puerta_front/functions/api_endpoints.dart';
import 'package:en_tu_puerta_front/models/auth_response.dart';
import 'package:en_tu_puerta_front/models/petition.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = Logger();

Future getToken() async {
  //Url de la pagina login
  var url = Uri.http(urlBase(), 'api/login');

  //Usario de validación para hacer el login
  var body = {'email': 'osvaldo.kassulke@example.org', 'password': 'password'};

  try {
    //Envio de la información a la página, donde retorna el token para poder llamar a las demás APIs
    var response = await http.post(
      url,
      headers: {'Accept': 'application/json'},
      body: body,
    );

    //logger.log(Level.info, 'Response status: ${response.statusCode}');
    //logger.log(Level.info, 'Response body: ${response.body}');

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      logger.log(Level.info, data);

      AuthResponse authResponse = AuthResponse.fromJson(data);


      return authResponse.token;

    } else {
      return null;
    }
  } catch (e) {
    logger.log(Level.error, 'Error: $e');
  }
}

Future getServices(String inputSearchBar, String? token) async {
  var url = Uri.http(
      '10.0.2.2:8000', 'api/v1/services', {'filter[name]': '*$inputSearchBar*'});
      
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


//REVISAR ESTO error de servidor
Future getUsers(String inputSearchBar, String? token) async {
  var url = Uri.http('10.0.2.2:8000', 'api/v1/users', {'fullname': '*$inputSearchBar*'});
      
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

//Me regresa las peticiones pero no entiendo que me regresa
Future getPetitionS(String userId, String? token) async {
  var url = Uri.http('10.0.2.2:8000', 'api/v1/petitions', {'filter[user]':'3&include=$userId'});
      
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

//REVISAR ESTO

Future postPetition(Petition petition,String? token) async {

  var url = Uri.http(urlBase(), 'api/v1/petitions');
  var body = petition.toJson();

  Map<String, String>? header;

  if (token != null) {
      header = {'Accept': 'application/json', 'Authorization': 'Bearer $token'};
    } else {
      header = {'Accept': 'application/json'};
    }

  try {
    var response = await http.post(
      url,
      headers: header,
      body: body,
    );

    //logger.log(Level.info, 'Response status: ${response.statusCode}');
    //logger.log(Level.info, 'Response body: ${response.body}');

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


/**
 * Petition todavía tiene atributos que no van 
 * Necesito el id del usuario con el que me estoy registrando
 * Buscar por nombre me da error 500
 * No entiendo la estructura de las petittion cuando las llamo 
 */