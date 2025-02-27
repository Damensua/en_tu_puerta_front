import 'package:flutter/material.dart';

// Componente que muestra los detalles de una notificación/solicitud
class NotificationDetails extends StatelessWidget {

  const NotificationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Construye la sección de detalles con información del cliente y servicio

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Detalles de la solicitud',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF001563),
            ),
          ),
          const SizedBox(height: 16),
          _buildDetailItem('Nombre completo:', '*Profile_Name* *Prof_LastName*'),
          _buildDetailItem('Tipo de servicio:', 'Técnico Ares Ramíres'),
          _buildDetailItem('Ubicación:', 'null'),
          _buildDetailItem('Notas adicionales:', 'null'),
        ],
      ),
    );
  }

  // Método auxiliar para construir items de detalle con estilo consistente
  Widget _buildDetailItem(String label, String value) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF001563),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
