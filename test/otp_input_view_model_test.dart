import 'package:flutter_test/flutter_test.dart';

import 'package:everwell/features/onboarding_auth/data/repositories/auth_repository.dart';
import 'package:everwell/features/onboarding_auth/data/services/mock_auth_service.dart';
import 'package:everwell/features/onboarding_auth/presentation/view_models/otp_input_view_model.dart';

void main() {
  test('OtpInputViewModel submit succeeds with mock OTP', () async {
    final vm = OtpInputViewModel(AuthRepository(const MockAuthService()));
    vm.addDigit('1');
    vm.addDigit('2');
    vm.addDigit('3');
    vm.addDigit('4');
    final ok = await vm.submit();
    expect(ok, isTrue);
    vm.dispose();
  });
}
