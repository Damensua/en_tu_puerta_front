import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/models/provider.dart';

// Página para mostrar los detalles del proveedor
class ProviderDetailScreen extends StatelessWidget {
  final Provider provider;

  const ProviderDetailScreen({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${provider.firstName} ${provider.lastName}'),
        backgroundColor: Colors.teal, // AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono y nombre del proveedor
            Row(
              children: [
                CircleAvatar(
                  radius: 40, 
                  backgroundColor: Colors.teal[100], 
                  child: Icon(Icons.person, size: 40, color: Colors.teal), 
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${provider.firstName} ${provider.lastName}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber), 
                        SizedBox(width: 4),
                        //Provider rating
                        Text(
                          provider.type,
                          style: TextStyle(fontSize: 16, color: Colors.grey[700]), 
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            // Dos cards para mostrar la ubicación y el horario del proveedor
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), 
                    ),
                    child: Container(
                      height: 100, 
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.teal[50], 
                      ),
                      child: Center(
                        child: Text(
                          'Empty Card',
                          style: TextStyle(fontSize: 18, color: Colors.teal[800]), // Placeholder text style
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Rounded corners
                    ),
                    child: Container(
                      height: 100, // Set a height for the card
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.teal[50], // Card background color
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on, color: Colors.red, size: 30), 
                          SizedBox(width: 8),
                          Text(
                            'Ubicación',
                            style: TextStyle(fontSize: 18, color: Colors.teal[800]), 
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Titulo de la sección servicios, aqui van los 
            Text(
              'Servicio',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}