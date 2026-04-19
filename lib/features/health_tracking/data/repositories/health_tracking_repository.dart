import '../../domain/models/health_tracking_models.dart';
import '../services/mock_health_tracking_service.dart';

class HealthTrackingRepository {
  HealthTrackingRepository(this._service);

  final MockHealthTrackingService _service;
  List<HeartRateRecord>? _cache;

  Future<List<HeartRateRecord>> getHeartRateRecords() async {
    _cache ??= await _service.fetchHeartRateRecords();
    return List.unmodifiable(_cache!);
  }

  Future<void> addHeartRateRecord(HeartRateRecord record) async {
    final list = List<HeartRateRecord>.from(await getHeartRateRecords());
    list.insert(0, record);
    _cache = list;
  }

  Future<List<HeartRateTrendPoint>> getHeartRateTrend() async {
    final records = await getHeartRateRecords();
    final sorted = [...records]
      ..sort((a, b) => a.measuredAt.compareTo(b.measuredAt));
    return sorted
        .map(
          (r) => HeartRateTrendPoint(
            label:
                '${r.measuredAt.day.toString().padLeft(2, '0')}/${r.measuredAt.month.toString().padLeft(2, '0')}',
            bpm: r.bpm,
          ),
        )
        .toList();
  }
}
