import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../data/repositories/onboarding_repository.dart';

/// Simulates NFC scan progress (Figma `806:4709`).
class NfcScanViewModel extends ChangeNotifier {
  NfcScanViewModel(this._repository);

  final OnboardingRepository _repository;

  double progress = 0.08;
  bool isComplete = false;
  String? errorMessage;
  Timer? _timer;
  bool _completionStarted = false;

  void start() {
    _timer?.cancel();
    _completionStarted = false;
    progress = 0.08;
    isComplete = false;
    errorMessage = null;
    notifyListeners();
    _timer = Timer.periodic(const Duration(milliseconds: 180), (_) async {
      progress = (progress + 0.07).clamp(0.0, 1.0);
      notifyListeners();
      if (progress >= 1.0 && !_completionStarted) {
        _completionStarted = true;
        _timer?.cancel();
        try {
          await _repository.runNfcScan();
          isComplete = true;
        } catch (e) {
          errorMessage = e.toString();
        }
        notifyListeners();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
