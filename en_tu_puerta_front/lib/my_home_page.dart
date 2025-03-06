import 'package:flutter/material.dart';
// import 'package:en_tu_puerta_front/widget_client/home_client_screen.dart';
import 'package:en_tu_puerta_front/widget_client/search_client_screen.dart';
//import 'package:en_tu_puerta_front/widget_client/chat_client_screen.dart';
//import 'package:en_tu_puerta_front/widget_client/settings_client_screen.dart';
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
    //WidgetNotification(),
    //WidgetSettings()
  ];

  /*void _selectOptionInMyBottomNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  } */

  @override
  Widget build(BuildContext context) {
    // Use the globalToken as needed
    print('Global Token: ${widget.globalToken}'); // Example usage

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.network(
              'https://i.postimg.cc/05h66XrJ/Artboard-1-copy-2-3x.png',
              width: 150,
              height: 150,
            ),
            SizedBox(width: 10),
            Spacer(),
            Icon(
              Icons.account_circle_outlined,
              size: 40,
              color: Color(0xFF001563)),
            // Add a button to navigate back to the pre-home screen
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => PreHomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      /* bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Búsqueda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
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
      ),*/
    );
  }
}
