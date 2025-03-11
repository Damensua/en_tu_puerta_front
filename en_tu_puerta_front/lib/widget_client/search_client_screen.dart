import 'package:en_tu_puerta_front/controllers/api_crontroller.dart';
import 'package:en_tu_puerta_front/functions/read_data.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:en_tu_puerta_front/widget_client/search_components/search_result_card.dart';
import 'package:en_tu_puerta_front/widget_client/detail_service_client_screen.dart';



final mensajito = Logger();

// Widget para la pantalla de búsqueda del cliente
class WidgetSearch extends StatefulWidget {
  const WidgetSearch({super.key});

  @override
  State<WidgetSearch> createState() => _WidgetSearchState();
}

// Estado que maneja la lógica de búsqueda y filtrado
class _WidgetSearchState extends State<WidgetSearch> {
  /////////////////////////////////////////

  //VARIABLES
  //Token//
  String? localToken = globalToken;

  // Controlador de la caja de texto para la búsqueda//
  final TextEditingController _searchController = TextEditingController();
  //Texto para el query//
  String searchText = '';
  //Lista de objetos Servicioss//
  List servicesFounds = [];

  ///////////////////////////////////////
  @override
  void initState() {
    super.initState();
    // Inicializa la lista filtrada con todos los elementos
    fetchServices(); // Llama a la función para obtener los servicios inicialmente

    // Listener que cambia el searchText
    _searchController.addListener(() {
      setState(() {
        searchText =
            _searchController.text; // Actualiza la variable con el texto actual
        fetchServices(); // Llama a la función para filtrar los servicios
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose the controller when done
    super.dispose();
  }

  // Función para obtener los servicios
  void fetchServices() async {
    var json = await getServices(searchText, localToken);
    mensajito.log(Level.debug, "JSON RETORNADO:$json");
      setState(() {
        servicesFounds = parseServices(json);
        mensajito.log(Level.info, "Objetos Servicio: $servicesFounds"); // Actualiza la lista de servicios encontrados
        
        // Imprimir el primer servicio si existe
        if (servicesFounds.isNotEmpty) {
          final firstService = servicesFounds.first;
          mensajito.i('''
Primer servicio encontrado:
ID: ${firstService.id}
Nombre: ${firstService.serviceName}
Proveedor: ${firstService.firstNameProvider} ${firstService.lastNameProvider}
Precio: ${firstService.servicePrice}
Dirección: ${firstService.addressProvider}
Descripción: ${firstService.description}
Duración: ${firstService.duration} minutos
Imágenes: ${firstService.imagesPath}
Puntuación: ${firstService.punctuationProvider}
''');
        }
      });

  }

  //Función para el onchange de la searchbar
  void updateSearch(String value) {
    setState(() {
      searchText = value; // Actualiza searchText
    });

    // Verificación de lo que se esta escribiendo
    mensajito.log(Level.info, "Searching for: $searchText");
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ENCABEZADO
      //Acomodar el espaciamiento de esto
      //Esya muy pegado arriba, debe estar entre la barra y el logo
      //Y el tipo de letra debe ser más grande y llamativo, y en azul
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Búsqueda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, // Hacer el texto más grueso
                color: Color(0xFF001563), // Cambiar el color si es necesario
              ),
            ),
          ],

        ),
      ),


      //RESTO DE LA VISTA
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Reduce el espacio vertical

            child: Row(
              children: [
                //BARRA DE BÚSQUEDA CON FILTRO INTEGRADO
                Expanded(
                  child: SearchBar(
                    controller: _searchController,
                    hintText: 'Buscar servicio...',
                    leading: Icon(Icons.search, color: Color(0xFF001563)),
                    trailing: [
                      PopupMenuButton<String>(
                        icon: Icon(Icons.filter_alt, color: Color(0xFF001563)),
                        onSelected: (String value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Filtro seleccionado: $value'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem<String>(
                            value: 'Servicio',
                            child: Text('Servicio'),
                          ),
                          PopupMenuItem<String>(
                            value: 'Cuenta',
                            child: Text('Cuenta'),
                          ),
                        ],
                      ),
                    ],
                    onChanged: updateSearch,
                  ),
                ),


              ],
            ),
          ),

          //Esta frase debe ir en el centro de la pantalla  tanto vertical como horizontalmente
          Expanded(
            child: searchText.isEmpty 
                ? Center(
                    child: Text(
                      '¿Qué deseas buscar hoy?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF001563),
                      ),
                    ),
                  )
                : servicesFounds.isEmpty
                    ? Center(
                        child: Text(
                          _searchController.text.isEmpty
                              ? '¿Qué deseas buscar hoy?'
                              : 'No se encontraron resultados',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF001563),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16.0),
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
                            child: SearchResultCard(
                              serviceName: service.serviceName,
                              providerName: '${service.firstNameProvider} ${service.lastNameProvider}',
                              price: service.servicePrice,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
