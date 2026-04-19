import 'attachment_item.dart';

/// Chi tiết C2 — Figma MCP `806:10716`.
class MedicalRecordDetail {
  final String id;
  final String mainDiagnosisCaption;
  final String mainDiagnosisTitle;
  final String visitDateLong;
  final String specialtyPill;
  final String facilityLabel;
  final String facilityName;
  final String doctorLabel;
  final String doctorName;
  final String diagnosisSectionTitle;
  final String diagnosisDetailCaption;
  final String diagnosisParagraph;
  final String adviceTitle;
  final List<String> adviceBullets;
  final String attachmentsSectionTitle;
  final String primaryAttachmentTitle;
  final String primaryAttachmentSubtitle;
  final List<AttachmentItem> attachments;

  const MedicalRecordDetail({
    required this.id,
    required this.mainDiagnosisCaption,
    required this.mainDiagnosisTitle,
    required this.visitDateLong,
    required this.specialtyPill,
    required this.facilityLabel,
    required this.facilityName,
    required this.doctorLabel,
    required this.doctorName,
    required this.diagnosisSectionTitle,
    required this.diagnosisDetailCaption,
    required this.diagnosisParagraph,
    required this.adviceTitle,
    required this.adviceBullets,
    required this.attachmentsSectionTitle,
    required this.primaryAttachmentTitle,
    required this.primaryAttachmentSubtitle,
    required this.attachments,
  });
}
