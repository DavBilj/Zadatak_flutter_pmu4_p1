import 'package:flutter/material.dart';

import '../models/quake.dart';
import '../services/quake_service.dart';
import '../widgets/magnitude_badge.dart';
import 'detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final Future<List<Quake>> _quakes;

  @override
  void initState() {
    super.initState();
    _quakes = const QuakeService().fetchQuakes();
  }

  Widget _buildDot(Quake quake, Size size) {
    return Positioned(
      left: (quake.longitude + 180) / 360 * size.width - 24, // -180 ... 180
      top: (90 - quake.latitude) / 180 * size.height - 24, // 90 ... -90
      child: child
      );
  }



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}