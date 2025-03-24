import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/models/auth_response.dart';
import 'package:en_tu_puerta_front/my_home_page.dart';
import 'package:en_tu_puerta_front/my_home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

// Pantalla de inicio que permite al usuario elegir entre ser cliente o proveedor
final mensajero = Logger();

String? globalClientToken;
AuthResponse? authResponseClient;
String? globalIdClient;

String? globalProviderToken;
AuthResponse? authResponseProvider;
String? globalIdProvider;

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
    authResponseClient = await getToken( 'client');
    globalClientToken = authResponseClient?.token;
    globalIdClient = authResponseClient?.idUser;

    authResponseProvider = await getToken('provider');
    globalProviderToken = authResponseProvider?.token;
    globalIdProvider = authResponseProvider?.idUser;
    setState(() {
      _isTokenInitialized = true;
    });
  }

  Future<String> fetchData() async {
    if (globalClientToken == null || globalProviderToken==null ) {
      throw Exception('Token is not available, Try Again');
    }
    return globalClientToken!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001563),
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
                              'https://i.postimg.cc/85XVXVzn/Entupuertanuevo.png',
                              height: 160,
                            ),
                            SizedBox(height: 20),
                            Text(
                              '¿Que necesitas?',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            //BOTON DE CLIENTE
                            SizedBox(height: 20),
                            Image.network(
                              'https://i.postimg.cc/pdZv8jbv/cliente.png',
                              height: 130,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage(
                                          title: 'Home',
                                          globalToken: globalClientToken)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                backgroundColor: Color(0xFF606d9e),
                              ),
                              child: Text('Solicitar servicio',
                                  style: TextStyle(color: Colors.white)),
                            ),

                            //BOTON DE PRESTADADOR
                            SizedBox(height: 20),
                            Image.network(
                              'https://i.postimg.cc/XJYbgv4C/proveedor.png',
                              height: 130,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                //



                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MyHomePageProvider(title: 'Home')),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                backgroundColor: Color(0xFF606d9e),
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
