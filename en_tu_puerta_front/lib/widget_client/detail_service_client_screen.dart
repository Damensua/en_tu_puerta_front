import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/widgets/reusable_button.dart';
import 'package:en_tu_puerta_front/widget_client/search_components/service_request_dialog.dart';
import 'package:en_tu_puerta_front/widgets/image_carousel.dart';


class DetailView extends StatelessWidget {
  final String name;
  final double price;
  final String description;
  final String providerImage;
  final String providerName;
  final double rating;
  final String location;

  const DetailView({
    required this.name,
    required this.price,
    required this.description,
    required this.providerImage,
    required this.providerName,
    required this.rating,
    required this.location,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Carrusel de imágenes
            ImageCarousel(
              imageUrls: [
                'https://picsum.photos/200/300',
                'https://picsum.photos/200/400',
                'https://picsum.photos/200/350',
              ],
            ),
            const SizedBox(height: 16),
            
            // Nombre del servicio

            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Precio
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Título Descripción
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Descripción del servicio
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            
            // Línea horizontal
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            
            // Información del prestador
            Row(
              children: [
                // Foto del prestador
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(providerImage),
                ),
                const SizedBox(width: 16),
                
                // Detalles del prestador
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre del prestador
                      Text(
                        providerName,
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
                            rating.toStringAsFixed(1),
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
                            location,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      // Botón fijo en la parte inferior
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReusableButton(
          text: 'Solicitar',
          color: const Color(0xFF001563),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => const ServiceRequestDialog(),
            );
          },
        ),
      ),
    );
  }
}
