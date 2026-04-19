class MockMedicationService {
  const MockMedicationService();

  Future<List<Map<String, dynamic>>> fetchPrescriptions() async {
    return [
      {
        'id': 'rx-1',
        'diagnosis': 'Viêm dạ dày cấp tính',
        'dateLabel': '24 THÁNG 05, 2024',
        'doctorName': 'BS. Nguyễn Văn An',
        'hospitalName': 'Bệnh viện Đa khoa Tâm Anh',
        'status': 'active',
        'medicineNames': ['Omeprazole', 'Motilium', 'Sucralfate'],
      },
      {
        'id': 'rx-2',
        'diagnosis': 'Viêm dạ dày cấp tính',
        'dateLabel': '24 THÁNG 05, 2024',
        'doctorName': 'BS. Nguyễn Văn An',
        'hospitalName': 'Bệnh viện Đa khoa Tâm Anh',
        'status': 'active',
        'medicineNames': ['Omeprazole', 'Motilium', 'Sucralfate'],
      },
      {
        'id': 'rx-3',
        'diagnosis': 'Rối loạn tiêu hóa',
        'dateLabel': '28 THÁNG 02, 2024',
        'doctorName': 'BS. Nguyễn Văn An',
        'hospitalName': 'Bệnh viện Đa khoa Tâm Anh',
        'status': 'completed',
        'medicineNames': ['Omeprazole', 'Motilium', 'Paracetamol'],
      },
    ];
  }

  Future<List<Map<String, dynamic>>> fetchCabinetMedicines() async {
    return [
      {
        'id': 'cab-1',
        'name': 'Omeprazole 20mg',
        'quantityLeft': 12,
        'expiryLabel': '12/2025',
        'status': 'normal',
      },
      {
        'id': 'cab-2',
        'name': 'Motilium 10mg',
        'quantityLeft': 5,
        'expiryLabel': '10/2025',
        'status': 'low',
      },
      {
        'id': 'cab-3',
        'name': 'Paracetamol 500mg',
        'quantityLeft': 2,
        'expiryLabel': '01/2026',
        'status': 'expired',
      },
    ];
  }

  Future<List<Map<String, dynamic>>> fetchReminders() async {
    return [
      {
        'id': 'rem-1',
        'timeLabel': '07:00',
        'periodLabel': 'Sáng',
        'medicineName': 'Omeprazole 20mg',
        'note': 'Trước ăn sáng 30 phút',
        'taken': false,
      },
      {
        'id': 'rem-2',
        'timeLabel': '12:30',
        'periodLabel': 'Trưa',
        'medicineName': 'Motilium 10mg',
        'note': 'Uống với nước ấm',
        'taken': true,
      },
    ];
  }

  Future<List<Map<String, dynamic>>> fetchAdherenceHistory() async {
    return [
      {
        'id': 'adh-1',
        'dateTimeLabel': '03/04/2026 07:05',
        'medicineName': 'Omeprazole 20mg',
        'statusLabel': 'Đã uống',
      },
      {
        'id': 'adh-2',
        'dateTimeLabel': '02/04/2026 20:12',
        'medicineName': 'Motilium 10mg',
        'statusLabel': 'Bỏ qua',
      },
    ];
  }
}
