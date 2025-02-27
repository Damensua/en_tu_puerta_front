import 'package:flutter/material.dart';
import 'provider_petition_components/petition_card.dart';

// Widget para la pantalla de notificaciones del proveedor
class WidgetProviderNotifications extends StatefulWidget {

  const WidgetProviderNotifications({super.key});

  @override
  State<WidgetProviderNotifications> createState() => _WidgetProviderNotificationsState();
}

// Estado que maneja la lógica de las notificaciones del proveedor
class _WidgetProviderNotificationsState extends State<WidgetProviderNotifications> {

  bool _showCard = true;

  // Método para aceptar una solicitud de servicio
  void _acceptRequest() {

    setState(() {
      _showCard = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de notificaciones con lista de solicitudes

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Solicitudes',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF001563),
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _showCard ? 1 : 0,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return NotificationCard(
                  profileName: '*Prof_Name*',
                  profLastName: '*Prof_LastName*',
                  onAccept: _acceptRequest,
                  onToggleDetails: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
