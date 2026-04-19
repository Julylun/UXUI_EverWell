import 'package:everwell/features/medication/presentation/pages/medication_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AddPrescriptionPage shows success dialog on upload action', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: AddPrescriptionPage()));

    await tester.tap(find.text('Chọn tệp ngay'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Tạo lịch nhắc nhở'), findsOneWidget);
    expect(find.textContaining('thành công!'), findsOneWidget);
  });
}
