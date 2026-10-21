import 'package:flutter/material.dart';
import 'screens/table_screen.dart';

void main() {
  runApp(const QuakesApp());
}

class QuakesApp extends StatelessWidget {
  const QuakesApp ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potresei',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const TableScreen(),
    );
  }
}
