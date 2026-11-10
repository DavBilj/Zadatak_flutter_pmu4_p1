import 'package:flutter/material.dart';
import '../models/position.dart';

class DetailScreen extends StatefulWidget {
  final Position position;

  const DetailScreen({super.key, required this.position});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final position = widget.position;
    
    return Scaffold(
      appBar: AppBar(title: Text(position.driverNumber.toString())),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 32),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: const Text('Driver number:'),
            trailing: Text(
              position.driverNumber.toString(),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.timer),
            title: const Text('Number of laps:'),
            trailing: Text(position.numberOfLaps.toString()),
          ),
          ListTile(
            leading: const Icon(Icons.plus_one),
            title: const Text('Points:'),
            trailing: Text(
              position.points.toString(),
            ),
          ),
        ],
      ),
    );
  }
}
