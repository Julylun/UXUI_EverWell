import 'package:flutter/foundation.dart';

import '../../data/repositories/medication_repository.dart';
import '../../domain/models/medication_models.dart';

class ReminderFlowViewModel extends ChangeNotifier {
  ReminderFlowViewModel(this._repository);

  final MedicationRepository _repository;

  bool isLoading = false;
  List<ReminderEvent> reminders = const [];
  List<AdherenceEvent> history = const [];

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    reminders = await _repository.listReminders();
    history = await _repository.listAdherenceHistory();
    isLoading = false;
    notifyListeners();
  }
}
