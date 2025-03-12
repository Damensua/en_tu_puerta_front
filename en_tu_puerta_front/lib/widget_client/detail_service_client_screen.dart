import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/widgets/reusable_button.dart';
import 'package:en_tu_puerta_front/widget_client/search_components/service_request_dialog.dart';
import 'package:en_tu_puerta_front/widgets/image_carousel.dart';
import 'package:en_tu_puerta_front/models/service.dart';



// ignore: must_be_immutable
class DetailServiceClientScreen extends StatelessWidget {
  Service service;

  DetailServiceClientScreen({
    required this.service,
    super.key,
  });


  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.serviceName),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Carrusel de imágenes
            ImageCarousel(
              imageUrls: [service.imagesPath],
            ),

            const SizedBox(height: 16),
            
            // Nombre del servicio

            Text(
              service.serviceName,

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Precio
            Text(
              '\$${service.servicePrice.toStringAsFixed(2)}',

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
              service.description,

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
                  backgroundImage: NetworkImage(service.imagesPath),

                ),
                const SizedBox(width: 16),
                
                // Detalles del prestador
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre del prestador
                      Text(
                        '${service.firstNameProvider} ${service.lastNameProvider}',

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
                            service.punctuationProvider.toStringAsFixed(1),

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
                            service.addressProvider,

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
              builder: (context) => ServiceRequestDialog(service: service),
            );
          },
        ),
      ),
    );
  }
}
