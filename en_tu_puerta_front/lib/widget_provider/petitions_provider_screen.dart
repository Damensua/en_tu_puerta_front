import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/models/petition.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'provider_petition_components/petition_card.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:en_tu_puerta_front/widget_provider/provider_petition_components/detail_petition_provider_screen.dart';

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
  String? localToken = globalProviderToken;
  String? userId = globalIdProvider;

  List petitionsFounds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPetitions();
  }

  Future<void> _loadPetitions() async {
    petitionsFounds.clear();
    _isLoading = true;
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


  void _acceptRequest(int index) {
    try {
      acceptPetition(petitionsFounds[index], localToken);

      setState(() {
        petitionsFounds.removeAt(index);
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Solicitud aceptada!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text('Se ha aceptado correctamente la solicitud.'),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    backgroundColor: Color(0xFF001563),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _loadPetitions();
                  },
                  child: Text(
                    'Aceptar',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } catch (Exception) {
      logger.log(Level.info, 'Error');
  }
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
                              petitionId: petition.id,
                              profileName: petition.firstNameUser,
                              profLastName: petition.lastNameUser,
                              onAccept: () {
                                _acceptRequest(index);
                                _loadPetitions();
                              },
                              onToggleDetails: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPetitionProviderScreen(
                                      petition: petition,
                                      onAccept: () {
                                        setState(() {
                                          petitionsFounds.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )),
        ],
      ),
    );
  }
}
