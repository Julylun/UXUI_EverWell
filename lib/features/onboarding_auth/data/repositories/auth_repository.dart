import '../../domain/models/auth_session.dart';
import '../services/mock_auth_service.dart';

/// SSOT for auth session in WS-A (mock-backed).
class AuthRepository {
  AuthRepository(this._service);

  final MockAuthService _service;

  AuthSession? _session;
  AuthSession? get session => _session;

  Future<void> login(String username, String password) async {
    _session = await _service.login(username: username, password: password);
  }

  Future<void> logout() async {
    _session = null;
  }

  Future<void> requestRegisterOtp(String email) {
    return _service.requestRegisterOtp(email: email);
  }

  Future<void> requestForgotOtp(String email) {
    return _service.requestForgotOtp(email: email);
  }

  Future<bool> verifyOtp(String code) {
    return _service.verifyOtp(code);
  }

  Future<void> resetPassword(String password, String confirm) {
    return _service.resetPassword(password: password, confirm: confirm);
  }
}
