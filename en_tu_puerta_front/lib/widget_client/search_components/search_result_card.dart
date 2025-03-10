import 'package:flutter/material.dart';

// Componente que muestra una tarjeta de resultado de búsqueda
class SearchResultCard extends StatelessWidget {
  final String serviceName;
  final String providerName;
  final double price;

  const SearchResultCard({
    required this.serviceName,
    required this.providerName,
    required this.price,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    // Construye la tarjeta de resultado con icono, nombre y precio
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: SingleChildScrollView( // Added scrollable functionality
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
                      serviceName, // Updated to serviceName
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                    Text(
                      providerName, // Added providerName
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis, // Prevent overflow
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '\$${price.toStringAsFixed(2)}',
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
