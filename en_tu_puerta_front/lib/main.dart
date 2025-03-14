
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:flutter/material.dart';


// Punto de entrada principal de la aplicación
void main() {  
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'En Tu Puerta',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PreHomeScreen(),
    );
  }
}