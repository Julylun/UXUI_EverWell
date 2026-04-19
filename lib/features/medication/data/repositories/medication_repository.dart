import '../../domain/models/medication_models.dart';
import '../services/mock_medication_service.dart';

class MedicationRepository {
  MedicationRepository(this._service);

  final MockMedicationService _service;

  Future<List<PrescriptionSummary>> listPrescriptions() async {
    final raw = await _service.fetchPrescriptions();
    return raw
        .map(
          (item) => PrescriptionSummary(
            id: item['id'] as String,
            diagnosis: item['diagnosis'] as String,
            dateLabel: item['dateLabel'] as String,
            doctorName: item['doctorName'] as String,
            hospitalName: item['hospitalName'] as String,
            status: (item['status'] as String) == 'active'
                ? PrescriptionStatus.active
                : PrescriptionStatus.completed,
            medicineNames:
                (item['medicineNames'] as List<dynamic>).cast<String>(),
          ),
        )
        .toList();
  }

  Future<List<CabinetMedicine>> listCabinetMedicines() async {
    final raw = await _service.fetchCabinetMedicines();
    return raw
        .map(
          (item) => CabinetMedicine(
            id: item['id'] as String,
            name: item['name'] as String,
            quantityLeft: item['quantityLeft'] as int,
            expiryLabel: item['expiryLabel'] as String,
            status: switch (item['status'] as String) {
              'low' => MedicineStockStatus.lowStock,
              'expired' => MedicineStockStatus.expired,
              _ => MedicineStockStatus.normal,
            },
          ),
        )
        .toList();
  }

  Future<List<ReminderEvent>> listReminders() async {
    final raw = await _service.fetchReminders();
    return raw
        .map(
          (item) => ReminderEvent(
            id: item['id'] as String,
            timeLabel: item['timeLabel'] as String,
            periodLabel: item['periodLabel'] as String,
            medicineName: item['medicineName'] as String,
            note: item['note'] as String,
            taken: item['taken'] as bool,
          ),
        )
        .toList();
  }

  Future<List<AdherenceEvent>> listAdherenceHistory() async {
    final raw = await _service.fetchAdherenceHistory();
    return raw
        .map(
          (item) => AdherenceEvent(
            id: item['id'] as String,
            dateTimeLabel: item['dateTimeLabel'] as String,
            medicineName: item['medicineName'] as String,
            statusLabel: item['statusLabel'] as String,
          ),
        )
        .toList();
  }
}
