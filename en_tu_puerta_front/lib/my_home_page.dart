import 'package:en_tu_puerta_front/widget_client/calendar_client_screen.dart';
import 'package:en_tu_puerta_front/widget_client/home_client_screen.dart';
import 'package:en_tu_puerta_front/widget_client/settings_client_screen.dart';
import 'package:flutter/material.dart';
import 'package:en_tu_puerta_front/widget_client/search_client_screen.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart'; 

import 'package:flutter/material.dart';

import 'package:en_tu_puerta_front/widget_client/search_client_screen.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart'; 

import 'package:en_tu_puerta_front/widget_client/home_client_screen.dart';
import 'package:en_tu_puerta_front/widget_client/search_client_screen.dart';

import 'package:en_tu_puerta_front/widget_client/calendar_client_screen.dart';
import 'package:en_tu_puerta_front/widget_client/settings_client_screen.dart';
import 'package:en_tu_puerta_front/pre_home_screen.dart'; // Import the pre-home screen



//Controlador principal de la aplicación en el rol de cliente
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.globalToken});

  final String title;
  final String? globalToken;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    //WidgetHome(),
    WidgetSearch(),
    WidgetCalendar(),
    //WidgetNotification(),
    //WidgetSettings()
  ];

  void _selectOptionInMyBottomNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
} 

  @override
  Widget build(BuildContext context) {
    // Use the globalToken as needed
    print('Global Token: $globalToken');


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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          // ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Búsqueda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendario',
          ),

          /* BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Perfil',
          ),*/

          // BottomNavigationBarItem(
          //   icon: Icon(Icons.notifications),
          //   label: 'Notificaciones',
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.list),
          //   label: 'Perfil',
          // ),

        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color(0xFF001563),
        onTap: _selectOptionInMyBottomNavigation,
      ),
    );
  }
}
