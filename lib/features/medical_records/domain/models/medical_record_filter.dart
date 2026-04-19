/// Bộ lọc hồ sơ (WS-C C3) — model thuần, không import Flutter.
class MedicalRecordFilter {
  final String? hospitalKeyword;
  final String? specialtyKeyword;

  const MedicalRecordFilter({
    this.hospitalKeyword,
    this.specialtyKeyword,
  });

  bool get isEmpty =>
      (hospitalKeyword == null || hospitalKeyword!.trim().isEmpty) &&
      (specialtyKeyword == null || specialtyKeyword!.trim().isEmpty);
}
