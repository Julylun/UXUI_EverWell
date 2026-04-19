/// Stateless mock — Figma MCP C1/C2 (`806:10937`, `806:10716`).
class MockMedicalRecordsService {
  const MockMedicalRecordsService();

  static final List<Map<String, dynamic>> _rows = _buildRows();

  static Map<String, dynamic> _base() => {
        'titleLine1': 'Viêm dạ dày mãn',
        'titleLine2': 'tính',
        'departmentPill': 'Nội Khoa',
        'dateLong': '24 Tháng 05, 2024',
        'doctorName': 'BS. Nguyễn Văn An',
        'hospital': 'Bệnh viện Đa khoa Tâm Anh',
        'attachmentLabel': '1 tệp đính kèm',
        'mainDiagnosisCaption': 'Chẩn đoán chính',
        'mainDiagnosisTitle': 'Viêm dạ dày mãn tính',
        'visitDateLong': '14 tháng 10, 2023',
        'specialtyPill': 'Nội khoa',
        'facilityLabel': 'CƠ SỞ Y TẾ',
        'facilityName': 'Bệnh viện Đa khoa Quốc tế',
        'doctorLabel': 'BÁC SĨ PHỤ TRÁCH',
        'diagnosisSectionTitle': 'Chẩn đoán & Y lệnh',
        'diagnosisDetailCaption': 'CHI TIẾT CHẨN ĐOÁN',
        'diagnosisParagraph':
            'Bệnh nhân có triệu chứng đau thượng vị kéo dài, ợ hơi, ợ chua. Kết quả nội soi cho thấy niêm mạc dạ dày xung huyết, trợt nhẹ. Chẩn đoán xác định Viêm dạ dày mãn tính do vi khuẩn HP.',
        'adviceTitle': 'CHỈ ĐỊNH & LỜI KHUYÊN',
        'adviceBullets': [
          'Ăn uống đúng giờ, tránh các thực phẩm cay nóng, chua, nhiều dầu mỡ.',
          'Kiêng rượu bia, cà phê và các chất kích thích.',
          'Uống thuốc đúng liều lượng theo đơn đã kê, không tự ý ngắt quãng.',
          'Tái khám sau 2 tuần hoặc khi có dấu hiệu bất thường.',
        ],
        'attachmentsSectionTitle': 'Tài liệu đính kèm',
        'primaryAttachmentTitle': 'Kết quả xét nghiệm máu',
        'primaryAttachmentSubtitle': 'PDF • 2.4 MB • 14/10/2023',
        'attachments': [
          {'id': 'a1', 'title': 'Kết quả xét nghiệm máu', 'subtitle': 'PDF · 2.4 MB'},
        ],
      };

  static List<Map<String, dynamic>> _buildRows() {
    final a = {..._base(), 'id': '1'};
    final b = {
      ..._base(),
      'id': '2',
      'dateLong': '10 Tháng 04, 2024',
      'visitDateLong': '10 tháng 4, 2024',
      'mainDiagnosisTitle': 'Theo dõi huyết áp',
      'diagnosisParagraph': 'Huyết áp ổn định, tiếp tục đo tại nhà.',
      'adviceBullets': ['Uống đủ nước.', 'Vận động vừa phải.'],
      'primaryAttachmentTitle': 'Phiếu đo HA',
      'primaryAttachmentSubtitle': 'Ảnh · 540 KB · 10/04/2024',
      'attachments': [
        {'id': 'b1', 'title': 'Phiếu đo HA', 'subtitle': 'Ảnh · 540 KB'},
      ],
    };
    final c = {
      ..._base(),
      'id': '3',
      'dateLong': '02 Tháng 01, 2025',
      'visitDateLong': '2 tháng 1, 2025',
      'mainDiagnosisTitle': 'Khám tổng quát',
      'diagnosisParagraph': 'Không ghi nhận bất thường trên lâm sàng.',
      'adviceBullets': ['Duy trì sinh hoạt lành mạnh.'],
      'attachmentLabel': 'Không có tệp đính kèm',
      'attachments': <Map<String, dynamic>>[],
      'primaryAttachmentTitle': '',
      'primaryAttachmentSubtitle': '',
    };
    return [a, b, c];
  }

  Future<List<Map<String, dynamic>>> fetchRawRecords() async {
    await Future<void>.delayed(Duration.zero);
    return _rows.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<Map<String, dynamic>?> fetchRawById(String id) async {
    await Future<void>.delayed(Duration.zero);
    try {
      final row = _rows.firstWhere((e) => e['id'] == id);
      return Map<String, dynamic>.from(row);
    } catch (_) {
      return null;
    }
  }
}
