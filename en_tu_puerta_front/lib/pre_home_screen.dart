import 'package:en_tu_puerta_front/my_home_page.dart';
import 'package:en_tu_puerta_front/my_home_page_provider.dart';
import 'package:flutter/material.dart';

// Pantalla de inicio que permite al usuario elegir entre ser cliente o proveedor
class PreHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF001563), // Updated background color
      body: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                'https://i.postimg.cc/85XVXVzn/Entupuertanuevo.png', // Updated image URL
                height: 150,
              ),
              Text(
                '¿Que necesitas?',
                style: TextStyle(
                  fontSize: 24, // Increased font size
                  color: Colors.white, // Updated title color
                ),
                textAlign: TextAlign.center,
              ),
              Image.network(
                'https://i.postimg.cc/pdZv8jbv/cliente.png', // Updated client icon URL
                height: 160, // Doubled size
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Home')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Color(0xFF606d9e), // Updated button color
                ),
                child: Text('Solicitar servicio', style: TextStyle(color: Colors.white)),
              ),
              Image.network(
                'https://i.postimg.cc/XJYbgv4C/proveedor.png', // Updated provider icon URL
                height: 160, // Doubled size
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePageProvider(title: 'Home')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Color(0xFF606d9e), // Updated button color
                ),
                child: Text('Ofrecer servicio', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
