import 'package:flutter/material.dart';

import '../../models/service.dart';

// Componente que muestra una tarjeta de resultado de búsqueda
class SearchResultCard extends StatelessWidget {
  final Service service;

  const SearchResultCard({
    required this.service,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Construye la tarjeta de resultado con icono, nombre y precio
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: SingleChildScrollView( 
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              service.imagesPath.startsWith('[') 
                ? Image.network(
                service.imagesPath
                .substring(1, service.imagesPath.length - 1) 
                .split(',')[0] 
                .replaceAll('"', '') 
                .trim(), 
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                )
                : Icon(Icons.work, size: 80, color: Color(0xFF001563)), // Icono fijo

              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.serviceName, 
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                    Text(
                      '${service.firstNameProvider} ${service.lastNameProvider}', 
                      style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${service.servicePrice}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
