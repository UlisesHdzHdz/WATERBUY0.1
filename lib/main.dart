import 'package:flutter/material.dart';

import 'login/inicio.dart';
import 'package:intl/date_symbol_data_local.dart';


void main() {
  initializeDateFormatting('es', null).then((_) { // Initialize Spanish locale data
    runApp(MyApp());
  });
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const IniciOne(),
    );
  }
}