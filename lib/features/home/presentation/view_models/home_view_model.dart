import 'package:flutter/foundation.dart';

import '../../data/repositories/home_repository.dart';
import '../../domain/models/home_dashboard.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._repository);

  final HomeRepository _repository;

  HomeDashboard? dashboard;
  bool isLoading = false;
  String? error;

  Future<void> load({bool forceRefresh = false}) async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      dashboard = await _repository.getDashboard(forceRefresh: forceRefresh);
    } catch (e) {
      error = e.toString();
      dashboard = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
