import 'package:en_tu_puerta_front/models/petition.dart';
import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/widgets/reusable_button.dart';

class DetailPetitionProviderScreen extends StatefulWidget {
  final Petition petition;
  final VoidCallback onAccept;

  const DetailPetitionProviderScreen(
      {Key? key, required this.petition, required this.onAccept})
      : super(key: key);

  @override
  _DetailPetitionProviderScreenState createState() =>
      _DetailPetitionProviderScreenState();
}

class _DetailPetitionProviderScreenState
    extends State<DetailPetitionProviderScreen> {
  void _acceptRequest(petition) async {
    try {
      await acceptPetition(petition.id, globalProviderToken);
      widget.onAccept();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Solicitud aceptada')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('La solicitud ya ha sido aceptada')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la Solicitud'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar del usuario
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.petition.imageUser ??
                  "https://i.pinimg.com/280x280_RS/61/1e/29/611e298177035a4ff0191a72b95d0976.jpg"),
            ),
            const SizedBox(height: 16),

            // Nombre del usuario
            Text(
              '${widget.petition.firstNameUser ?? 'Usuario'} ${widget.petition.lastNameUser ?? ''}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Estado de la solicitud
            Text(
              'Estado: ${widget.petition.status ?? 'Desconocido'}',
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 16),

            // Información del servicio
            const Text(
              'Servicio solicitado:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.petition.nameService ?? 'No especificado',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Fecha y hora de la solicitud
            const Text(
              'Fecha y hora:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${widget.petition.date} - ${widget.petition.time}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Mensaje del usuario
            const Text(
              'Mensaje:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.petition.message ?? 'Sin mensaje',
              style: const TextStyle(fontSize: 16),
            ),
            ReusableButton(
              text: 'Aceptar solicitud',
              color: const Color(0xFF001563),
              onPressed: () {
                _acceptRequest(widget.petition);
              },
            ),
          ],
        ),
      ),
    );
  }
}
