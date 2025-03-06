
import 'package:en_tu_puerta_front/pre_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


// Punto de entrada principal de la aplicación
void main() {
  final logger= Logger();
  
  logger.e('Error Log',error: "Test Error", stackTrace: StackTrace.empty);
  logger.i('Info Log', error: "Test Info", stackTrace: StackTrace.empty);
  logger.w('Warning Log',error: "Test Warning", stackTrace: StackTrace.empty);
  logger.d('Debug Log',error:"Test Debug", stackTrace: StackTrace.empty);
  logger.f('Fatal Log',error:"Test Failed", stackTrace: StackTrace.empty);
  
  runApp(const MyApp());
}

// Clase principal que configura la aplicación Flutter
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