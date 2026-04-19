import '../../domain/models/health_tracking_models.dart';

class MockHealthTrackingService {
  const MockHealthTrackingService();

  Future<List<HeartRateRecord>> fetchHeartRateRecords() async {
    return [
      HeartRateRecord(
        bpm: 92,
        measuredAt: DateTime(2026, 4, 15, 9, 30),
        isResting: false,
        note: 'Đi bộ nhanh buổi sáng',
      ),
      HeartRateRecord(
        bpm: 76,
        measuredAt: DateTime(2026, 4, 14, 14, 15),
        isResting: true,
        note: '',
      ),
      HeartRateRecord(
        bpm: 71,
        measuredAt: DateTime(2026, 4, 13, 8, 0),
        isResting: true,
        note: '',
      ),
      HeartRateRecord(
        bpm: 74,
        measuredAt: DateTime(2026, 4, 12, 11, 45),
        isResting: true,
        note: '',
      ),
    ];
  }
}
