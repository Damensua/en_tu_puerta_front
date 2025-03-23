import 'package:flutter/material.dart';
import 'package:your_project/models/service.dart'; // Adjust the import according to your project structure

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.work, size: 40, color: Color(0xFF001563)), // Icono fijo

              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name, 
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                    Text(
                      service.providerName, 
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis, 
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${service.price.toStringAsFixed(2)}',
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
