import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:everwell/features/home/presentation/pages/home_page.dart';

void main() {
  testWidgets('HomePage shows Figma B1 greeting and quick access', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomePage()));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.textContaining('Xin chào'), findsWidgets);
    expect(find.text('Truy cập nhanh'), findsOneWidget);
    expect(find.text('Hồ sơ khám'), findsOneWidget);
  });
}
