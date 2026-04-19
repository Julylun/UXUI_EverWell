/// Mock “raw” payload — map sang [HomeDashboard] ở repository (Figma B1).
class MockHomeService {
  const MockHomeService();

  Future<Map<String, dynamic>> fetchDashboardRaw() async {
    await Future<void>.delayed(Duration.zero);
    return {
      'greetingHeadline': 'Xin chào 👋',
      'dateLine': 'Thứ Sáu, 3 tháng 4, 2026',
      'alertTitleLine1': 'Bạn có 2 liều thuốc cần',
      'alertTitleLine2': 'uống trong hôm nay.',
      'alertSubtitleLine1': 'Kiểm tra ngay lịch uống thuốc',
      'alertSubtitleLine2': 'bên dưới.',
      'recentPreview': {
        'recordId': '1',
        'titleLine1': 'Khám sức khỏe tổng',
        'titleLine2': 'quát',
        'hospitalLine1': 'Bệnh viện Đại học Y',
        'hospitalLine2': 'Dược',
        'dateShort': '12/03/2026',
        'statusLabel': 'Hoàn tất',
      },
    };
  }
}
