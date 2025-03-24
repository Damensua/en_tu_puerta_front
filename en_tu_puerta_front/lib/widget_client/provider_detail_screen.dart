import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/functions/read_data.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:en_tu_puerta_front/widget_client/detail_service_client_screen.dart';
import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/models/provider.dart';
import 'package:logger/logger.dart';

final mensajito = Logger();

class ProviderDetailScreen extends StatefulWidget {
  final Provider provider;

  const ProviderDetailScreen({super.key, required this.provider});

  @override
  _ProviderDetailScreenState createState() => _ProviderDetailScreenState();
}


// Página para mostrar los detalles del proveedor
class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  String? localToken = globalClientToken;
  List servicesFounds = [];
  late int userId;

  @override
  void initState() {
    super.initState();
    userId = widget.provider.id; // Inicializa userId aquí
    fetchServices(); // Llama a la función para obtener los prestadores
  }
  
  // Función para obtener los servicios
  void fetchServices() async {
    var json = await getOwnServices(userId, localToken);
    mensajito.log(Level.debug, "JSON RETORNADO:$json");
    setState(() {
      servicesFounds = parseServices(json);
      mensajito.log(Level.info, "Objetos Servicio: $servicesFounds, cantidad de servicios: ${servicesFounds.length}"); // Actualiza la lista de servicios encontrados
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.provider.firstName} ${widget.provider.lastName}'), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icono y nombre del proveedor
            Row(
                children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                  widget.provider.profileImagePath.replaceAll('"', ''),
                  ),
                  backgroundColor: Color(0xFF001563),
                ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  '${widget.provider.firstName} ${widget.provider.lastName}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF001563)),
                ),
                SizedBox(height: 4),
                Text(
                  '@${widget.provider.username}',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Color(0xFF606D9E)), 
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                  Icon(Icons.star, color: Colors.amber), 
                  SizedBox(width: 4),
                  Text(
                    widget.provider.punctuation.toDouble().toString(),
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                color: Color(0xFF001563),
                ),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(
                  'Horario',
                  style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Inicio: ${widget.provider.startTime}',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Fin: ${widget.provider.endTime}',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                ],
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
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFF001563),
                ),
                child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.location_on, color: Colors.red, size: 22),
                  SizedBox(width: 4),
                  Text(
                    'Ubicación',
                    style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                  ),
                  ],
                ),
                SizedBox(height: 8),
                Flexible(
                  child: Text(
                  widget.provider.address,
                  style: TextStyle(fontSize: 11, color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  ),
                ),
                ],
                ),
                ),
              ),
              ),
              ),
              ],
            ),
            SizedBox(height: 16),

            // Titulo de la sección servicios, aqui van los servicios
            Text(
              'Servicios',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF001563)),
            ),

            Expanded(
              child: ListView.builder(
              padding: EdgeInsets.all(9.0),
              itemCount: servicesFounds.length,
              itemBuilder: (context, index) {
                final service = servicesFounds[index];
                return GestureDetector(
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailServiceClientScreen(
                    service: service,
                    ),
                  ),
                  );
                },
                
                child: SizedBox(
                  width: 300, 
                  height: 120, 
                  child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center( 
                    child: ListTile(
                    title: Text(
                      service.serviceName,
                      style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF001563),
                      ),
                    ),
                    subtitle: Text(
                      '${service.firstNameProvider} ${service.lastNameProvider}',
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    trailing: Text(
                      '\$${service.servicePrice}',
                      style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      ),
                    ),
                    ),
                  ),
                  ),
                ),
                );
              },
              ),
            ),
          ],
        ),
      ),
    );
  }
}