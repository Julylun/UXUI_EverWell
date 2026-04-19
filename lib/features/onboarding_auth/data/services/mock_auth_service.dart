import '../../domain/models/auth_session.dart';

/// Stateless mock API (UI-only phase).
class MockAuthService {
  const MockAuthService();

  static const String mockOtp = '1234';

  Future<AuthSession> login({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (username.trim().isEmpty || password.trim().isEmpty) {
      throw StateError('invalid_credentials');
    }
    return AuthSession(userId: username.trim(), displayName: username.trim());
  }

  Future<void> requestRegisterOtp({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    if (!email.contains('@')) {
      throw StateError('invalid_email');
    }
  }

  Future<void> requestForgotOtp({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    if (!email.contains('@')) {
      throw StateError('invalid_email');
    }
  }

  Future<bool> verifyOtp(String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    return code == mockOtp;
  }

  Future<void> resetPassword({
    required String password,
    required String confirm,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    if (password.length < 6 || password != confirm) {
      throw StateError('invalid_password');
    }
  }
}
