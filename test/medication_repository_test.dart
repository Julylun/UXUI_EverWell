import 'package:everwell/features/medication/data/repositories/medication_repository.dart';
import 'package:everwell/features/medication/data/services/mock_medication_service.dart';
import 'package:everwell/features/medication/domain/models/medication_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MedicationRepository.listPrescriptions splits active/completed', () async {
    final repo = MedicationRepository(const MockMedicationService());
    final list = await repo.listPrescriptions();
    expect(list.length, 3);
    expect(
      list.where((e) => e.status == PrescriptionStatus.active).length,
      2,
    );
  });

  test('MedicationRepository.listCabinetMedicines returns stock states', () async {
    final repo = MedicationRepository(const MockMedicationService());
    final list = await repo.listCabinetMedicines();
    expect(list.length, 3);
    expect(list.any((e) => e.status == MedicineStockStatus.expired), isTrue);
  });
}
