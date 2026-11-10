import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/position.dart';

    class PositionService {
  const PositionService();

    static final _feed = Uri.parse(
    'https://api.openf1.org/v1/session_result?session_key=latest',
  );

  Future<List<Position>> fetchPositions() async {
    await Future.delayed(const Duration(seconds: 5));

final response = await http
    .get(_feed)
    .timeout(const Duration(seconds: 15));

    if (response.statusCode != 200) {
      throw Exception(
        'Baza je vratila status ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as List<dynamic>;

        return json
        .map((game) => Position.fromJson(game as Map<String, dynamic>))
        .toList();
  }
}


