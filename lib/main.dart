import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/everwell_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Ẩn status bar + navigation bar; vuốt từ cạnh để hiện tạm rồi tự ẩn lại.
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ),
  );
  runApp(const EverWellApp());
}
