import 'package:flutter/material.dart';

/// WS-B will replace this route (`AppRoutes.home`).
class HomePlaceholderPage extends StatelessWidget {
  const HomePlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trang chủ (placeholder)')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Đây là placeholder cho WS-B — Home / dashboard.\n'
            'Luồng onboarding hoàn tất sẽ điều hướng tới đây.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
