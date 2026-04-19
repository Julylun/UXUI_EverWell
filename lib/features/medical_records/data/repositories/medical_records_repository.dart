import '../../domain/models/attachment_item.dart';
import '../../domain/models/medical_record_detail.dart';
import '../../domain/models/medical_record_filter.dart';
import '../../domain/models/medical_record_summary.dart';
import '../services/mock_medical_records_service.dart';

/// SSOT danh sách & chi tiết hồ sơ (mock).
class MedicalRecordsRepository {
  MedicalRecordsRepository(this._service);

  final MockMedicalRecordsService _service;

  List<MedicalRecordSummary>? _cache;

  Future<List<MedicalRecordSummary>> listRecords({
    MedicalRecordFilter? filter,
    bool forceRefresh = false,
  }) async {
    if (_cache == null || forceRefresh) {
      final raw = await _service.fetchRawRecords();
      _cache = raw.map(_mapSummary).toList();
    }
    final base = _cache!;
    if (filter == null || filter.isEmpty) return List.of(base);
    return base.where((r) {
      final h = filter.hospitalKeyword?.trim().toLowerCase();
      final s = filter.specialtyKeyword?.trim().toLowerCase();
      final okH = h == null || h.isEmpty || r.hospital.toLowerCase().contains(h);
      final okS = s == null ||
          s.isEmpty ||
          r.departmentPill.toLowerCase().contains(s);
      return okH && okS;
    }).toList();
  }

  Future<MedicalRecordDetail?> getDetail(String id) async {
    final raw = await _service.fetchRawById(id);
    if (raw == null) return null;
    return _mapDetail(raw);
  }

  MedicalRecordSummary _mapSummary(Map<String, dynamic> m) {
    return MedicalRecordSummary(
      id: m['id']! as String,
      titleLine1: m['titleLine1']! as String,
      titleLine2: m['titleLine2']! as String,
      departmentPill: m['departmentPill']! as String,
      dateLong: m['dateLong']! as String,
      doctorName: m['doctorName']! as String,
      hospital: m['hospital']! as String,
      attachmentLabel: m['attachmentLabel']! as String,
    );
  }

  MedicalRecordDetail _mapDetail(Map<String, dynamic> m) {
    final atts = (m['attachments'] as List<dynamic>? ?? [])
        .map(
          (e) => AttachmentItem(
            id: (e as Map)['id']! as String,
            title: e['title']! as String,
            subtitle: e['subtitle']! as String,
          ),
        )
        .toList();
    final bullets = (m['adviceBullets'] as List<dynamic>? ?? [])
        .map((e) => e as String)
        .toList();
    return MedicalRecordDetail(
      id: m['id']! as String,
      mainDiagnosisCaption: m['mainDiagnosisCaption']! as String,
      mainDiagnosisTitle: m['mainDiagnosisTitle']! as String,
      visitDateLong: m['visitDateLong']! as String,
      specialtyPill: m['specialtyPill']! as String,
      facilityLabel: m['facilityLabel']! as String,
      facilityName: m['facilityName']! as String,
      doctorLabel: m['doctorLabel']! as String,
      doctorName: m['doctorName']! as String,
      diagnosisSectionTitle: m['diagnosisSectionTitle']! as String,
      diagnosisDetailCaption: m['diagnosisDetailCaption']! as String,
      diagnosisParagraph: m['diagnosisParagraph']! as String,
      adviceTitle: m['adviceTitle']! as String,
      adviceBullets: bullets,
      attachmentsSectionTitle: m['attachmentsSectionTitle']! as String,
      primaryAttachmentTitle: m['primaryAttachmentTitle']! as String,
      primaryAttachmentSubtitle: m['primaryAttachmentSubtitle']! as String,
      attachments: atts,
    );
  }
}
