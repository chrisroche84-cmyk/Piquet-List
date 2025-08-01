import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(PiquetListApp());
}

class PiquetListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piquet List',
      theme: ThemeData.dark(),
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
