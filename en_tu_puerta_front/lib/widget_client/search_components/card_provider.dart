import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/models/provider.dart';
import 'package:en_tu_puerta_front/widget_client/provider_detail_screen.dart'; 

// Widget para mostrar la información del proveedor
class CardProvider extends StatelessWidget {
  final Provider provider;

  const CardProvider({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.5),
      child: Column(
      children: [
        GestureDetector(
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProviderDetailScreen(provider: provider),
          ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
            ),
          ],
          ),
          child: Row(
          children: [
            // Foto del prestador
            CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(provider.profileImagePath.replaceAll('"', '')),
            ),
            const SizedBox(width: 16),

            // Detalles del prestador
            Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              // Nombre del prestador
              Text(
                '${provider.firstName} ${provider.lastName}',
                style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),

              // Rating en estrellas
              Row(
                children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  provider.punctuation.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 14),
                ),
                ],
              ),
              const SizedBox(height: 4),

              // Ubicación
              Row(
                children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Text(
                  provider.address,
                  style: const TextStyle(fontSize: 12),
                ),
                ],
              ),
              ],
            ),
            ),
          ],
          ),
        ),
        ),
        const SizedBox(height: 16),
      ],
      ),
    );
  }
  }

