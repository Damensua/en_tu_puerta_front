import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:en_tu_puerta_front/controllers/first_crontroller.dart'; // Import FirstController


import 'package:flutter/material.dart';
import 'detail_service_client_screen.dart';
import 'search_components/search_result_card.dart';
import 'search_components/search_service.dart';
import 'search_components/mock_providers.dart';
import 'search_components/provider_card.dart';


// Widget para la pantalla de búsqueda del cliente
class WidgetSearch extends StatefulWidget {
  WidgetSearch({super.key});


  @override
  State<WidgetSearch> createState() => _WidgetSearchState();
}

// Estado que maneja la lógica de búsqueda y filtrado
class _WidgetSearchState extends State<WidgetSearch> {
  String? localToken = globalToken;
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredResults = [];
  List<Map<String, dynamic>> _filteredProviders = [];


  // Filtra los resultados basados en la consulta de búsqueda
  Future<void> _filterResults(String query) async {
    setState(() {
      if (query.isEmpty) {
        _filteredResults = [];
        _filteredProviders = [];
      } else {
        _filteredResults = SearchService.mockResults
            .where((result) => result['name']
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        _filteredProviders = ProviderService.mockProviders
            .where((provider) => provider['name']
                .toLowerCase()
                .contains(query.toLowerCase()) ||
                provider['serviceType']
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });

    // Call the getServices method from FirstController
    var servicesResponse = await getServices(query, localToken);


    String localhost = 'localhost'; // Define your localhost variable
    var services = await getServices('/services', localToken);
    // Handle the services response as needed
    print(services);
  }

  @override
  Widget build(BuildContext context) {
    // Construye la interfaz de búsqueda con SearchBar y lista de resultados
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(color: Color(0xFF001563)),
                    decoration: InputDecoration(
                      hintText: 'Buscar servicio...',
                      hintStyle: TextStyle(color: Color(0xFF001563).withOpacity(0.6)),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF001563)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF001563)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF001563)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF001563), width: 2),
                      ),
                    ),
                    onChanged: _filterResults,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_alt, color: Color(0xFF001563)),
                  onPressed: () {
                    print(localToken);
                  },

                ),
              ],
            ),
          ),
          Expanded(
            child: _filteredResults.isEmpty && _filteredProviders.isEmpty
                ? Center(
                    child: Text(
                      _searchController.text.isEmpty
                          ? '¿Qué deseas buscar hoy?'
                          : 'No se encontraron resultados',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF001563),
                      ),
                    ),
                  )
                : ListView(
                    padding: EdgeInsets.all(16.0),
                    children: [
                      if (_filteredResults.isNotEmpty)
                        ..._filteredResults.map((result) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailView(
                                      name: result['name'],
                                      price: result['price'],
                                      description: result['description'],
                                      providerImage: result['providerImage'],
                                      providerName: result['providerName'],
                                      rating: result['rating'],
                                      location: result['location'],
                                    ),
                                  ),
                                );
                              },
                              child: SearchResultCard(
                                icon: result['icon'],
                                serviceName: result['name'],
                                providerName: result['providerName'],
                                price: result['price'],
                              ),
                            )),
                      if (_filteredProviders.isNotEmpty)
                        ..._filteredProviders.map((provider) => ProviderCard(
                              name: provider['name'],
                              serviceType: provider['serviceType'],
                              rating: provider['rating'],
                              imageUrl: provider['imageUrl'],
                              location: provider['location'],
                              description: provider['description'],
                              experience: provider['experience'],
                              priceRange: provider['priceRange'],
                            )),
                    ],
                  ),

          ),
        ],
      ),
    );
  }
}
