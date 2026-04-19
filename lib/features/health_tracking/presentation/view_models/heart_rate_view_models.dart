import 'package:flutter/material.dart';

import '../../data/repositories/health_tracking_repository.dart';
import '../../domain/models/health_tracking_models.dart';

class HeartRateInputViewModel extends ChangeNotifier {
  HeartRateInputViewModel(this._repository);

  final HealthTrackingRepository _repository;

  int? bpm;
  bool isResting = true;
  DateTime selectedDate = DateTime(2026, 4, 16);
  TimeOfDay? selectedTime;
  String note = '';
  bool isSaving = false;

  void increaseBpm() {
    final value = (bpm ?? 72) + 1;
    bpm = value.clamp(30, 220);
    notifyListeners();
  }

  void decreaseBpm() {
    final value = (bpm ?? 72) - 1;
    bpm = value.clamp(30, 220);
    notifyListeners();
  }

  void setBpm(int value) {
    bpm = value.clamp(30, 220);
    notifyListeners();
  }

  void setResting(bool value) {
    isResting = value;
    notifyListeners();
  }

  void setDate(DateTime value) {
    selectedDate = DateTime(value.year, value.month, value.day);
    notifyListeners();
  }

  void setTime(TimeOfDay value) {
    selectedTime = value;
    notifyListeners();
  }

  void setNote(String value) {
    note = value;
  }

  Future<void> save() async {
    if (bpm == null) return;
    isSaving = true;
    notifyListeners();
    final time = selectedTime ?? const TimeOfDay(hour: 9, minute: 30);
    final measuredAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      time.hour,
      time.minute,
    );
    await _repository.addHeartRateRecord(
      HeartRateRecord(
        bpm: bpm!,
        measuredAt: measuredAt,
        isResting: isResting,
        note: note.trim(),
      ),
    );
    isSaving = false;
    notifyListeners();
  }
}

class HeartRateDetailViewModel extends ChangeNotifier {
  HeartRateDetailViewModel(this._repository);

  final HealthTrackingRepository _repository;

  bool isLoading = false;
  String? error;
  List<HeartRateRecord> records = const [];
  List<HeartRateTrendPoint> trend = const [];

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      records = await _repository.getHeartRateRecords();
      trend = await _repository.getHeartRateTrend();
    } catch (_) {
      error = 'Không thể tải dữ liệu nhịp tim.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
