/// Mock EMR / NFC onboarding (delays only).
class MockOnboardingService {
  const MockOnboardingService();

  Future<void> simulateNfcScan() async {
    await Future<void>.delayed(const Duration(seconds: 2));
  }

  Future<void> simulateEmrImport({required String source}) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (source.isEmpty) throw StateError('invalid_source');
  }
}
