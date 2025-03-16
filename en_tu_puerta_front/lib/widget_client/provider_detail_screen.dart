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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre: ${provider.firstName} ${provider.lastName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Username: ${provider.username}'),
            SizedBox(height: 8),
            Text('Email: ${provider.email}'),
            SizedBox(height: 8),
            Text('Address: ${provider.address}'),
          ],
        ),
      ),
    );
  }
}
