import 'package:flutter/material.dart';
import 'package:pmu4_p1/models/position.dart';

class PositionTile extends StatelessWidget {
  final Position position;
  final bool pinned;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDismissed;

  const PositionTile({
    super.key,
    required this.position,
    required this.pinned,
    required this.onTap,
    required this.onLongPress,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(position.driverNumber),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) => onDismissed(),
      child: ListTile(
        title:Text(position.driverNumber.toString()),
        subtitle: Text('Gap to leader: ${position.gap}'),
        trailing: AnimatedScale
        (scale: pinned ? 1: 0, 
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        child: const Icon(Icons.push_pin)
        ),
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}

