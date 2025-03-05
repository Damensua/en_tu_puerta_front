//import 'dart:convert';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
final logger= Logger();

class FirstCrontroller {
  //Aqui  adentro colocare todas las metodos de
  //nuestro controlador de cron, como por ejemplo:
  //los get, los post, los updates, los deletes

  Future<void> getData() async {

    //Url de la pagina login
    var url =Uri.http('10.0.2.2:8001', 'api/login'); 

    //Usario de validación para hacer el login
    var body = {
      'email': 'kuvalis.hillard@example.org', 
      'password': 'password' 
    };

    try {
      //Envio de la información a la página, donde retorna el token para poder llamar a las demás APIs

      var response = await http.post(url,headers: {'Accept': 'application/json'},body: body,);

      logger.log(Level.info, 'Response status: ${response.statusCode}');
      logger.log(Level.info, 'Response body: ${response.body}');
      
      if(response.statusCode==200){
      var data =jsonDecode(response.body);
        logger.log(Level.info, data.runtimeType);
      }



    
    } catch (e) {
      logger.log(Level.error, 'Error: $e');

    }
  }
}
