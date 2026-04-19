import 'package:flutter/foundation.dart';

import '../../data/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel(this._repository);

  final AuthRepository _repository;

  bool isLoading = false;
  String? errorMessage;

  Future<bool> submit(String username, String password) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await _repository.login(username, password);
      return true;
    } catch (_) {
      errorMessage = 'Đăng nhập thất bại. Kiểm tra tên và mật khẩu.';
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
