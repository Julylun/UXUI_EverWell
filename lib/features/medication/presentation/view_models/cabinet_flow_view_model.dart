import 'package:flutter/foundation.dart';

import '../../data/repositories/medication_repository.dart';
import '../../domain/models/medication_models.dart';

class CabinetFlowViewModel extends ChangeNotifier {
  CabinetFlowViewModel(this._repository);

  final MedicationRepository _repository;

  bool isLoading = false;
  List<CabinetMedicine> medicines = const [];

  Future<void> load() async {
    isLoading = true;
    notifyListeners();
    medicines = await _repository.listCabinetMedicines();
    isLoading = false;
    notifyListeners();
  }
}
