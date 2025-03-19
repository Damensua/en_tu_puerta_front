import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/models/provider.dart';
import 'package:en_tu_puerta_front/widget_client/provider_detail_screen.dart'; 

// Widget para mostrar la información del proveedor
class CardProvider extends StatelessWidget {
  final Provider provider;

  const CardProvider({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegar a la pantalla de detalles del proveedor
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderDetailScreen(provider: provider),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${provider.firstName} ${provider.lastName}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF001563),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Username: ${provider.username}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Email: ${provider.email}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Address: ${provider.address}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
