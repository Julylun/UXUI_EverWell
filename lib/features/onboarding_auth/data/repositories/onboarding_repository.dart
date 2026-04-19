import '../services/mock_onboarding_service.dart';

class OnboardingRepository {
  OnboardingRepository(this._service);

  final MockOnboardingService _service;

  String? _lastImportSource;
  String? get lastImportSource => _lastImportSource;

  Future<void> runNfcScan() => _service.simulateNfcScan();

  Future<void> importFrom(String source) async {
    await _service.simulateEmrImport(source: source);
    _lastImportSource = source;
  }

  void clearImport() {
    _lastImportSource = null;
  }
}
