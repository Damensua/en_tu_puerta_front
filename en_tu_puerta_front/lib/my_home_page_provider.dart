import 'package:en_tu_puerta_front/widget_provider/create_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/widget_provider/home_provider_screen.dart';
import 'package:en_tu_puerta_front/widget_provider/petitions_provider_screen.dart';

import 'package:en_tu_puerta_front/widget_provider/calendar_provider_screen.dart';

import 'package:en_tu_puerta_front/widget_provider/chat_provider_screen.dart';
import 'package:en_tu_puerta_front/widget_provider/settings_provider_screen.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart'; // Import the pre-home screen

//Controlador principal de la aplicación en el rol de proveedor
class MyHomePageProvider extends StatefulWidget {
  const MyHomePageProvider({super.key, required this.title});
  final String title;

  @override
  State<MyHomePageProvider> createState() => _MyHomePageProviderState();
}

class _MyHomePageProviderState extends State<MyHomePageProvider> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    WidgetProviderHome(),
    WidgetProviderNotifications(),
    WidgetCalendar(),
    //WidgetProviderMetrics(),
    CreateEventScreen(),
    //WidgetProviderSettings()
  ];

  void _selectOptionInMyBottomNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PreHomeScreen()),
                );
              },
              child: Image.network(
                'https://i.postimg.cc/05h66XrJ/Artboard-1-copy-2-3x.png',
                width: 150,
                height: 150,
              ),
            ),
          ],
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),

      //NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.auto_graph_outlined),
          //   label: 'Metricas',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Añadir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFF001563),
        onTap: _selectOptionInMyBottomNavigation,
      ),
    );
  }
}
