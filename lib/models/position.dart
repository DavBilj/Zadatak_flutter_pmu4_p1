
class Position {
  final String sessionKey;
  final String meetingKey;
  final int year;
  final String sessionName;
  final int driverNumber;
  final String date;
  final int numberOfLaps;
  final String dnf;
  final String dns;
  final String dsq;
  final String gap;
  final int points;


  Position({
    required this.sessionKey,
    required this.meetingKey,
    required this.year,
    required this.sessionName,
    required this.driverNumber,
    required this.date,
    required this.numberOfLaps,
    required this.dnf,
    required this.dns,
    required this.dsq,
    required this.gap,
    required this.points,
  });

  String get timeLabel {
    final parsedDate = DateTime.tryParse(date);

    if (parsedDate == null) {
      return 'Nepoznato';
    }

    final minute = parsedDate.minute.toString().padLeft(2, '0');

    return '${parsedDate.day}. ${parsedDate.month}. u ${parsedDate.hour}:$minute';
  }

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      sessionKey: json['session_key']?.toString() ?? '',
      meetingKey: json['meeting_key']?.toString() ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      sessionName: json['session_name']?.toString() ?? 'Nepoznato',
      driverNumber: (json['driver_number'] as num?)?.toInt() ?? 0,
      date: json['date']?.toString() ?? '',
      numberOfLaps: (json['number_of_laps'] as num?)?.toInt() ?? 0,
      dnf: json['dnf']?.toString() ?? '',
      dns: json['dns']?.toString() ?? '',
      dsq: json['dsq']?.toString() ?? '',
      gap: json['gap_to_leader']?.toString() ?? '',
      points: (json['points'] as num?)?.toInt() ?? 0,
    );
  }
}
