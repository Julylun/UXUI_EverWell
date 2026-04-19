import 'package:flutter/foundation.dart';

import '../../data/repositories/medication_repository.dart';
import '../../domain/models/medication_models.dart';

class PrescriptionFlowViewModel extends ChangeNotifier {
  PrescriptionFlowViewModel(this._repository);

  final MedicationRepository _repository;

  bool isLoading = false;
  String? error;
  List<PrescriptionSummary> active = const [];
  List<PrescriptionSummary> completed = const [];

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      final all = await _repository.listPrescriptions();
      active = all.where((e) => e.status == PrescriptionStatus.active).toList();
      completed =
          all.where((e) => e.status == PrescriptionStatus.completed).toList();
    } catch (e) {
      error = 'Không tải được đơn thuốc: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
