import 'package:en_tu_puerta_front/widget_provider/provider_petition_components/petition_details_screen.dart';
import 'package:flutter/material.dart';


// Componente de tarjeta para mostrar notificaciones/solicitudes al proveedor
class NotificationCard extends StatefulWidget {

  final String profileName;
  final String profLastName;
  final VoidCallback onAccept;
  final VoidCallback onToggleDetails;

  const NotificationCard({
    super.key,
    required this.profileName,
    required this.profLastName,
    required this.onAccept,
    required this.onToggleDetails,
  });

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

// Estado que maneja la lógica y visualización de la tarjeta de notificación
class _NotificationCardState extends State<NotificationCard> {

  bool _showDetails = false;

  // Alterna la visibilidad de los detalles de la notificación
  void _toggleDetails() {

    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de la tarjeta de notificación con animaciones poyo

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                    Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      'https://i.postimg.cc/05h66XrJ/Artboard-1-copy-2-3x.png',
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.profileName} ${widget.profLastName}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF001563),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _buildActionButton(
                              text: 'Ver detalles',
                              onPressed: () {
                                widget.onToggleDetails();
                                _toggleDetails();
                              },
                              color: Colors.blue.shade800,
                            ),
                            const SizedBox(width: 12),
                            _buildActionButton(
                              text: 'Aceptar',
                              onPressed: widget.onAccept,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Min Restantes: 10',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (_showDetails) NotificationDetails(),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir botones de acción estilizados
  Widget _buildActionButton({

    required String text,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
