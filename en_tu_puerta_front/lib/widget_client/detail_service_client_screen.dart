import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/models/provider.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/widgets/reusable_button.dart';
import 'package:en_tu_puerta_front/widget_client/search_components/service_request_dialog.dart';
import 'package:en_tu_puerta_front/widgets/image_carousel.dart';
import 'package:en_tu_puerta_front/models/service.dart';
import 'package:logger/logger.dart';
import 'package:en_tu_puerta_front/widget_client/provider_detail_screen.dart'; 

final mensajito = Logger();


class DetailServiceClientScreen extends StatefulWidget {
  final Service service;

  const DetailServiceClientScreen({
    required this.service,
    super.key,
  });

  @override
  _DetailServiceClientScreenState createState() => _DetailServiceClientScreenState();
}

class _DetailServiceClientScreenState extends State<DetailServiceClientScreen> {
  String? localToken = globalClientToken;
  late Provider mainProvider = Provider(
    id: 0,
    username: '',
    profileImagePath: '',
    type: '', 
    firstName: '', 
    lastName: '', 
    email: '', 
    address: '', 
    startTime: '', 
    endTime: '', 
    punctuation: 0, 
  );
   bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProvider(); // Llama a la función para obtener el proveedor
  }



//Funcion para obtener los prestadores de servicios
  void fetchProvider() async {
    isLoading = true;
    var json = await getServiceOwner(widget.service.idProvider, localToken);
    isLoading = false;
    
    setState(() {
      mainProvider = parseProvider(json);
      mensajito.log(Level.info,
          "Nombre de usuario, dueño del servicio ${mainProvider.username}");
    });
  }



  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service.serviceName),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Carrusel de imágenes
            widget.service.imagesPath.startsWith('[')
              ? ImageCarousel(
                imageUrls: List<String>.from(
                  widget.service.imagesPath
                    .substring(1, widget.service.imagesPath.length - 1)
                    .split(',')
                    .map((e) => e.trim().replaceAll('"', '')),
                ),
                )
                : const Center(
                child: Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: Colors.grey,
                ),
                ),

            const SizedBox(height: 16),
            
            // Nombre del servicio

            Text(
              widget.service.serviceName,

              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Precio
            Text(
              '\$${widget.service.servicePrice.toStringAsFixed(2)}',

              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Título Descripción
            const Text(
              'Descripción',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Descripción del servicio
            Text(
              widget.service.description,

              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            
            // Línea horizontal
            const Divider(thickness: 1),
            const SizedBox(height: 16),
            
            const SizedBox(height: 16),
            // Información del prestador
            isLoading
              ? const Center(
                child: CircularProgressIndicator(),
              )
              : 
              
              GestureDetector(
                onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => ProviderDetailScreen(provider: mainProvider),
                  ),
                );
                },
                child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                  // Foto del prestador
                    CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(mainProvider.profileImagePath.replaceAll('"', '')),
                    ),
                  const SizedBox(width: 16),

                  // Detalles del prestador
                  Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nombre del prestador
                      Text(
                      '${widget.service.firstNameProvider} ${widget.service.lastNameProvider}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const SizedBox(height: 4),

                      // Rating en estrellas
                      Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                        widget.service.punctuationProvider.toStringAsFixed(1),
                        style: const TextStyle(fontSize: 14),
                        ),
                      ],
                      ),
                      const SizedBox(height: 4),

                      // Ubicación
                      Row(
                      children: [
                        const Icon(Icons.location_on, size: 16),
                        const SizedBox(width: 4),
                        Text(
                        widget.service.addressProvider,
                        style: const TextStyle(fontSize: 12),
                        ),
                      ],
                      ),
                    ],
                    ),
                  ),
                  ],
                ),
                ),
              )
          ],
        ),
      ),


      // Botón fijo en la parte inferior
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ReusableButton(
          text: 'Solicitar servicio',
          color: const Color(0xFF001563),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ServiceRequestDialog(service: widget.service),
            );
          },
        ),
      ),
    );
  }
}
