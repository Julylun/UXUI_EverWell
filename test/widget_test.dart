import 'package:flutter_test/flutter_test.dart';

import 'package:everwell/app/everwell_app.dart';

void main() {
  testWidgets('EverWell starts on Welcome with primary CTA', (tester) async {
    await tester.pumpWidget(const EverWellApp());
    await tester.pumpAndSettle();
    expect(find.text('Bắt đầu'), findsWidgets);
    expect(find.textContaining('EVERWELL'), findsWidgets);
  });
}
