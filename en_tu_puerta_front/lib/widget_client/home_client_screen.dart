import 'package:flutter/material.dart';

// Widget principal para la pantalla de inicio del cliente
class WidgetHome extends StatelessWidget {

  const WidgetHome({super.key});

  @override
  Widget build(BuildContext context) {
    // Retorna un contenedor gris con texto de prueba

    return Container(
      color: Colors.grey,
      child: Text('Index 0: Home'),
      
    );
  }
}
