import 'package:flutter_test/flutter_test.dart';

import 'package:everwell/features/onboarding_auth/data/repositories/auth_repository.dart';
import 'package:everwell/features/onboarding_auth/data/services/mock_auth_service.dart';

void main() {
  test('AuthRepository.login stores session', () async {
    final repo = AuthRepository(const MockAuthService());
    expect(repo.session, isNull);
    await repo.login('user', 'secret12');
    expect(repo.session, isNotNull);
    expect(repo.session!.userId, 'user');
  });

  test('AuthRepository.verifyOtp accepts mock code', () async {
    final repo = AuthRepository(const MockAuthService());
    final ok = await repo.verifyOtp(MockAuthService.mockOtp);
    expect(ok, isTrue);
    final bad = await repo.verifyOtp('0000');
    expect(bad, isFalse);
  });
}
