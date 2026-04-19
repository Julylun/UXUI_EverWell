class PrescriptionSummary {
  const PrescriptionSummary({
    required this.id,
    required this.diagnosis,
    required this.dateLabel,
    required this.doctorName,
    required this.hospitalName,
    required this.status,
    required this.medicineNames,
  });

  final String id;
  final String diagnosis;
  final String dateLabel;
  final String doctorName;
  final String hospitalName;
  final PrescriptionStatus status;
  final List<String> medicineNames;
}

enum PrescriptionStatus { active, completed }

class CabinetMedicine {
  const CabinetMedicine({
    required this.id,
    required this.name,
    required this.quantityLeft,
    required this.expiryLabel,
    required this.status,
  });

  final String id;
  final String name;
  final int quantityLeft;
  final String expiryLabel;
  final MedicineStockStatus status;
}

enum MedicineStockStatus { normal, lowStock, expired }

class ReminderEvent {
  const ReminderEvent({
    required this.id,
    required this.timeLabel,
    required this.periodLabel,
    required this.medicineName,
    required this.note,
    required this.taken,
  });

  final String id;
  final String timeLabel;
  final String periodLabel;
  final String medicineName;
  final String note;
  final bool taken;
}

class AdherenceEvent {
  const AdherenceEvent({
    required this.id,
    required this.dateTimeLabel,
    required this.medicineName,
    required this.statusLabel,
  });

  final String id;
  final String dateTimeLabel;
  final String medicineName;
  final String statusLabel;
}
