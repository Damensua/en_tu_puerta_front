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
  void _acceptRequest(petition, onAccept) async {
    try {
      await acceptPetition(petition, globalProviderToken);
      Navigator.pop(context);
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
                  onAccept();
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
    } catch (e) {
      //logger.log(Level.info, e);
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
            Center(
              child: CircleAvatar(
              radius: 90,
              backgroundImage: NetworkImage(
                widget.petition.imageUser?.replaceAll('"', '') ?? 'https://i.postimg.cc/05h66XrJ/Artboard-1-copy-2-3x.png',
              ),
              ),
            ),
            const SizedBox(height: 16),

            // Nombre del usuario
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                'Fecha:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(
                widget.petition.date,
                style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                const Text(
                'Hora:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                ),
                Text(
                widget.petition.time ?? 'No especificada',
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
              ],
              ),
            ),
            const SizedBox(height: 90),

            Align(
              alignment: Alignment.bottomCenter,
              child: ReusableButton(
              text: 'Aceptar solicitud',
              color: const Color(0xFF001563),
              onPressed: () {
                _acceptRequest(widget.petition, widget.onAccept);
              },
              ),
            ),
            ],
        ),
      ),
    );
  }
}
