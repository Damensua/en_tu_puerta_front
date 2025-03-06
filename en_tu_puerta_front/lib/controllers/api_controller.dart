import 'dart:convert';
import 'dart:math';

import 'package:en_tu_puerta_front/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

final logger = Logger();
ApiController controlsito = ApiController();

class ApiController {
  Future get(endpoint, urlbase, token) async {
    Map<String, String>? header;

    if (token != null) {
      header = {'Accept': 'application/json', 'authorization': '$token'};
    } else {
      header = {'Accept': 'application/json'};
    }

    var url = Uri.http(urlbase, endpoint);
    logger.log(Level.info, url);

    try {
      var response = await http.get(url, headers: header);
      logger.log(Level.info, response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        logger.log(Level.info, data);
        return data['data'];
      } else {
        return null;
      }
    } catch (e) {
      logger.log(Level.error, 'Error: $e');
    }
  }

  Future post(endpoint, token, urlbase, header, body) async {
    Map<String, String>? header;

    if (token != null) {
      header = {'Accept': 'application/json', 'authorization': '$token'};
    } else {
      header = {'Accept': 'application/json'};
    }

    var url = Uri.http('urlbase', 'endpoint');
    try {
      var response = await http.post(
        url,
        headers: header,
        body: body,
      );

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

  Future getToken() async {
    //Url de la pagina login
    var url = Uri.http('10.0.2.2:8001', 'api/login');

    //Usario de validación para hacer el login
    var body = {'email': 'kuvalis.hillard@example.org', 'password': 'password'};

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
}
