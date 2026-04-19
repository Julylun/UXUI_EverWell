import 'package:flutter/foundation.dart';

import '../../domain/models/medical_record_detail.dart';
import '../../data/repositories/medical_records_repository.dart';

class MedicalRecordDetailViewModel extends ChangeNotifier {
  MedicalRecordDetailViewModel(this._repository, this.recordId);

  final MedicalRecordsRepository _repository;
  final String recordId;

  MedicalRecordDetail? detail;
  bool isLoading = false;
  String? error;

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      detail = await _repository.getDetail(recordId);
      if (detail == null) {
        error = 'Không tìm thấy hồ sơ';
      }
    } catch (e) {
      error = e.toString();
      detail = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
