import 'package:flutter_test/flutter_test.dart';

import 'package:everwell/features/medical_records/data/repositories/medical_records_repository.dart';
import 'package:everwell/features/medical_records/data/services/mock_medical_records_service.dart';
import 'package:everwell/features/medical_records/domain/models/medical_record_filter.dart';

void main() {
  test('MedicalRecordsRepository.listRecords returns mock rows', () async {
    final repo = MedicalRecordsRepository(const MockMedicalRecordsService());
    final list = await repo.listRecords();
    expect(list.length, 3);
    expect(list.first.id, '1');
    expect(list.first.titleLine1, 'Viêm dạ dày mãn');
    expect(list.first.departmentPill, 'Nội Khoa');
  });

  test('MedicalRecordsRepository.listRecords filters by hospital keyword',
      () async {
    final repo = MedicalRecordsRepository(const MockMedicalRecordsService());
    final list = await repo.listRecords(
      filter: const MedicalRecordFilter(hospitalKeyword: 'Tâm'),
    );
    expect(list.length, 3);
    expect(list.every((e) => e.hospital.contains('Tâm')), isTrue);
  });

  test('MedicalRecordsRepository.listRecords filters by specialty pill',
      () async {
    final repo = MedicalRecordsRepository(const MockMedicalRecordsService());
    final list = await repo.listRecords(
      filter: const MedicalRecordFilter(specialtyKeyword: 'Nội'),
    );
    expect(list.isNotEmpty, isTrue);
    expect(list.every((e) => e.departmentPill.contains('Nội')), isTrue);
  });

  test('MedicalRecordsRepository.getDetail returns detail or null', () async {
    final repo = MedicalRecordsRepository(const MockMedicalRecordsService());
    final d = await repo.getDetail('1');
    expect(d, isNotNull);
    expect(d!.adviceBullets.length, 4);
    final missing = await repo.getDetail('999');
    expect(missing, isNull);
  });
}
