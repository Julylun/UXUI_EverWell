import 'package:flutter/foundation.dart';

import '../../data/repositories/auth_repository.dart';

class OtpInputViewModel extends ChangeNotifier {
  OtpInputViewModel(this._repository);

  final AuthRepository _repository;

  String digits = '';
  bool isSubmitting = false;
  String? errorMessage;

  static const int length = 4;

  void addDigit(String d) {
    if (digits.length >= length) return;
    if (d.length != 1 || int.tryParse(d) == null) return;
    digits += d;
    errorMessage = null;
    notifyListeners();
  }

  void backspace() {
    if (digits.isEmpty) return;
    digits = digits.substring(0, digits.length - 1);
    notifyListeners();
  }

  void clear() {
    digits = '';
    errorMessage = null;
    notifyListeners();
  }

  Future<bool> submit() async {
    if (digits.length != length) {
      errorMessage = 'Nhập đủ $length số';
      notifyListeners();
      return false;
    }
    isSubmitting = true;
    errorMessage = null;
    notifyListeners();
    try {
      final ok = await _repository.verifyOtp(digits);
      if (!ok) {
        errorMessage = 'OTP không đúng (thử $length số đúng từ mock: 1234)';
        return false;
      }
      return true;
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
