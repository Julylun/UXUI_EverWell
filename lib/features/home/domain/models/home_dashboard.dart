class HomeRecentVisit {
  final String recordId;
  final String titleLine1;
  final String titleLine2;
  final String hospitalLine1;
  final String hospitalLine2;
  final String dateShort;
  final String statusLabel;

  const HomeRecentVisit({
    required this.recordId,
    required this.titleLine1,
    required this.titleLine2,
    required this.hospitalLine1,
    required this.hospitalLine2,
    required this.dateShort,
    required this.statusLabel,
  });
}

/// Trang chủ B1 — copy theo Figma MCP `806:11044`.
class HomeDashboard {
  final String greetingHeadline;
  final String dateLine;
  final String alertTitleLine1;
  final String alertTitleLine2;
  final String alertSubtitleLine1;
  final String alertSubtitleLine2;
  final HomeRecentVisit recentPreview;

  const HomeDashboard({
    required this.greetingHeadline,
    required this.dateLine,
    required this.alertTitleLine1,
    required this.alertTitleLine2,
    required this.alertSubtitleLine1,
    required this.alertSubtitleLine2,
    required this.recentPreview,
  });
}
