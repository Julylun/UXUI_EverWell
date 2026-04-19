/// Hàng danh sách C1 — Figma MCP `806:10937`.
class MedicalRecordSummary {
  final String id;
  final String titleLine1;
  final String titleLine2;
  final String departmentPill;
  final String dateLong;
  final String doctorName;
  final String hospital;
  final String attachmentLabel;

  const MedicalRecordSummary({
    required this.id,
    required this.titleLine1,
    required this.titleLine2,
    required this.departmentPill,
    required this.dateLong,
    required this.doctorName,
    required this.hospital,
    required this.attachmentLabel,
  });
}
