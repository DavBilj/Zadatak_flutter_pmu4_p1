import 'package:flutter/material.dart';

import '../models/position.dart';
import '../services/position_service.dart';
import '../screens/detail_screen.dart';
import '../widgets/position_tile.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _service = const PositionService();
  late Future<List<Position>> _positions;
  final _removed = <String>{}; // Set<String>
  final _pinned = <String>{}; // Set<String>

  @override
  void initState() {
    super.initState();
    _positions = _service.fetchPositions();
  }

  Future<void> _reload() {
    setState(() {
      _positions = _service.fetchPositions();
    });
    return _positions;
  }

  void _openDetail(Position position) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        pageBuilder: (context, animation, secondaryAnimation) =>
            DetailScreen(position: position),
      ),
    );
  }

  void _togglePin(Position position) {
    setState(() {
      if (!_pinned.remove(position.driverNumber.toString())) {
        _pinned.add(position.driverNumber.toString());
      }
    });
  }

  void _remove(Position position) {
    setState(() {
      _removed.add(position.driverNumber.toString());
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Uklonjeno: ${position.driverNumber}'),
        action: SnackBarAction(
          label: 'Poništi',
          onPressed: () {
            if (!mounted) return;
            setState(() {
              _removed.remove(position.driverNumber.toString());
            });
          },
        ),
      ),
    );
  }

  Widget _buildList(List<Position> positions) {
    final visible = positions.where((p) => !_removed.contains(p.driverNumber.toString())).toList();

    if (visible.isEmpty) {
      return const Center(child: Text('Nema sesije za prikaz'));
    }

    return RefreshIndicator(
      onRefresh: _reload,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: visible.length,
        itemBuilder: (context, index) {
          final position = visible[index];
          return PositionTile(
            position: position,
            pinned: _pinned.contains(position.driverNumber.toString()),
            onTap: () => _openDetail(position),
            onLongPress: () => _togglePin(position),
            onDismissed: () => _remove(position),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Utrka')),
      body: FutureBuilder<List<Position>>(
        future: _positions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48),
                  const SizedBox(height: 12),
                  Text('${snapshot.error}'),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _reload,
                    child: const Text('Pokušaj ponovno'),
                  ),
                ],
              ),
            );
          }
          return _buildList(snapshot.data!);
        },
      ),
    );
  }
}
