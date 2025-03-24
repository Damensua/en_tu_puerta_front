import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/models/petition.dart';
import 'package:flutter/material.dart';
import 'provider_petition_components/petition_card.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';

// Widget para la pantalla de notificaciones del proveedor
class WidgetProviderNotifications extends StatefulWidget {
  const WidgetProviderNotifications({super.key});

  @override
  State<WidgetProviderNotifications> createState() =>
      _WidgetProviderNotificationsState();
}

// Estado que maneja la lógica de las notificaciones del proveedor
class _WidgetProviderNotificationsState
    extends State<WidgetProviderNotifications> {
  String? localToken = globalClientToken;
  String? userId = globalIdClient;

  List petitionsFounds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPetitions();
  }

  Future<void> _loadPetitions() async {
    if (await getPetitionsByIdUser(userId, localToken) != null) {
      List<Petition> fetchedPetitions =
          await getPetitionsByIdUser(userId, localToken);

      setState(() {
        for (var petitionMap in fetchedPetitions) {
          if (petitionMap.status == "Enviada") {
            petitionsFounds.add(petitionMap);
          }
        }
        _isLoading = false;
      });
    }
  }

  // Método para aceptar una solicitud de servicio
  void _acceptRequest(int index) {
    setState(() {
      petitionsFounds.removeAt(index);
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
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : petitionsFounds.isEmpty
                    ? Center(
                        child: Text(
                          'No tiene solicitudes pendientes',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF001563),
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.0),
                        itemCount: petitionsFounds.length,
                        itemBuilder: (context, index) {
                          final petition = petitionsFounds[index];
                          return NotificationCard(
                            profileName: petition.firstNameUser,
                            profLastName: petition.lastNameUser,
                            onAccept: () {
                              _acceptRequest(index);
                            },
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
