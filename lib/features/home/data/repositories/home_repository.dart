import '../../domain/models/home_dashboard.dart';
import '../services/mock_home_service.dart';

class HomeRepository {
  HomeRepository(this._service);

  final MockHomeService _service;

  HomeDashboard? _cache;

  Future<HomeDashboard> getDashboard({bool forceRefresh = false}) async {
    if (_cache != null && !forceRefresh) return _cache!;
    final raw = await _service.fetchDashboardRaw();
    final r = raw['recentPreview'] as Map<String, dynamic>;
    _cache = HomeDashboard(
      greetingHeadline: raw['greetingHeadline']! as String,
      dateLine: raw['dateLine']! as String,
      alertTitleLine1: raw['alertTitleLine1']! as String,
      alertTitleLine2: raw['alertTitleLine2']! as String,
      alertSubtitleLine1: raw['alertSubtitleLine1']! as String,
      alertSubtitleLine2: raw['alertSubtitleLine2']! as String,
      recentPreview: HomeRecentVisit(
        recordId: r['recordId']! as String,
        titleLine1: r['titleLine1']! as String,
        titleLine2: r['titleLine2']! as String,
        hospitalLine1: r['hospitalLine1']! as String,
        hospitalLine2: r['hospitalLine2']! as String,
        dateShort: r['dateShort']! as String,
        statusLabel: r['statusLabel']! as String,
      ),
    );
    return _cache!;
  }
}
