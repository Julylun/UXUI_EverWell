class HeartRateRecord {
  const HeartRateRecord({
    required this.bpm,
    required this.measuredAt,
    required this.isResting,
    required this.note,
  });

  final int bpm;
  final DateTime measuredAt;
  final bool isResting;
  final String note;
}

class HeartRateTrendPoint {
  const HeartRateTrendPoint({required this.label, required this.bpm});

  final String label;
  final int bpm;
}
