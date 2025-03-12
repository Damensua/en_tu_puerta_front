import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/models/auth_response.dart';
import 'package:en_tu_puerta_front/my_home_page.dart';
import 'package:en_tu_puerta_front/my_home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Pantalla de inicio que permite al usuario elegir entre ser cliente o proveedor
final mensajero = Logger();

String? globalToken;
AuthResponse? authResponse;
String? globalIdUser;

class PreHomeScreen extends StatefulWidget {
  const PreHomeScreen({super.key});

  @override
  State<PreHomeScreen> createState() => _PreHomeScreenState();
}

class _PreHomeScreenState extends State<PreHomeScreen> {
  bool _isTokenInitialized = false;
  @override
  void initState() {
    super.initState();
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    authResponse = await getToken(); 
    globalToken=authResponse?.token;
    globalIdUser=authResponse?.idUser;
    setState(() {
      _isTokenInitialized =
          true;
    });
  }

  Future<String> fetchData() async {
    if (globalToken == null) {
      throw Exception('Token is not available');
    }
    return globalToken!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001563), // Updated background color
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Center(
            child: _isTokenInitialized
                ? FutureBuilder<String>(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(color: Colors.white),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://i.postimg.cc/85XVXVzn/Entupuertanuevo.png', // Updated image URL
                              height: 160, // Height of the top image
                            ),
                            SizedBox(
                                height:
                                    20), // Space between the top image and the text
                            Text(
                              '¿Que necesitas?',
                              style: TextStyle(
                                fontSize: 24, // Increased font size
                                color: Colors.white, // Updated title color
                              ),
                              textAlign: TextAlign.center,
                            ),

                            //BOTON DE CLIENTE
                            SizedBox(
                                height:
                                    20), // Space between the text and the first image
                            Image.network(
                              'https://i.postimg.cc/pdZv8jbv/cliente.png', // Updated client icon URL
                              height:
                                  130, // Updated height to 130 for the client icon
                            ),
                            ElevatedButton(
                              onPressed: () {
                                var messi1 = getServices('', globalToken);

                                var messi2 = getUsers('Jose', globalToken);

                                var messi3 = getPetitionS('1', globalToken);

                                mensajero.log(Level.info,
                                    'Este es la respuesta de los srvicios a la llamada de la API:$messi1');

                                mensajero.log(Level.info,
                                    'Este es la respuesta de los srvicios a la llamada de la API:$messi2');

                                mensajero.log(Level.info,
                                    'Este es la respuesta de los srvicios a la llamada de la API:$messi3');
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                          title: 'Home',
                                          globalToken: globalToken)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                backgroundColor:
                                    Color(0xFF606d9e), // Updated button color
                              ),
                              child: Text('Solicitar servicio',
                                  style: TextStyle(color: Colors.white)),
                            ),

                            //BOTON DE PRESTADADOR
                            SizedBox(
                                height:
                                    20), // Space between the button and the second image
                            Image.network(
                              'https://i.postimg.cc/XJYbgv4C/proveedor.png', // Updated provider icon URL
                              height:
                                  130, // Updated height to 130 for the provider icon
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePageProvider(
                                          title: 'Home')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                backgroundColor:
                                    Color(0xFF606d9e), // Updated button color
                              ),
                              child: Text('Ofrecer servicio',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        );
                      }
                    },
                  )
                : CircularProgressIndicator()),
      ),
    );
  }
}
