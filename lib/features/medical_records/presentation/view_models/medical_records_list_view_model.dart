import 'package:flutter/foundation.dart';

import '../../domain/models/medical_record_filter.dart';
import '../../domain/models/medical_record_summary.dart';
import '../../data/repositories/medical_records_repository.dart';

class MedicalRecordsListViewModel extends ChangeNotifier {
  MedicalRecordsListViewModel(this._repository);

  final MedicalRecordsRepository _repository;

  List<MedicalRecordSummary> records = [];
  MedicalRecordFilter activeFilter = const MedicalRecordFilter();
  bool isLoading = false;
  String? error;

  Future<void> load({bool forceRefresh = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      records = await _repository.listRecords(
        filter: activeFilter.isEmpty ? null : activeFilter,
        forceRefresh: forceRefresh,
      );
    } catch (e) {
      error = e.toString();
      records = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setFilter(MedicalRecordFilter filter) {
    activeFilter = filter;
    load();
  }
}
