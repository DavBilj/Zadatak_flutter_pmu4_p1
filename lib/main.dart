import 'package:flutter/material.dart';
import 'package:pmu4_p1/screens/list_screen.dart';

void main() {
  runApp(const SessionApp());
}

class SessionApp extends StatelessWidget {
  const SessionApp ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Utrka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ListScreen(),
    );
  }
}
