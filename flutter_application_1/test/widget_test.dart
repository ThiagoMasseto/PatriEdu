import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('PatriEduApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const PatriEduApp());
    expect(find.text('PatriEdu'), findsWidgets);
  });
}