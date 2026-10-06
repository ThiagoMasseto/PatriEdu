import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/screens/coordinator/coordinator_main_screen.dart';
import 'package:flutter_application_1/screens/coordinator/docentes_tab.dart';
import 'package:flutter_application_1/screens/coordinator/patrimonios_tab.dart';
import 'package:flutter_application_1/core/theme/app_theme.dart';

void main() {
  testWidgets('Test Coordinator tabs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const CoordinatorMainScreen(),
      ),
    );
    await tester.pumpAndSettle();

    // Tap Patrimonios tab
    await tester.tap(find.text('Patrimônios'));
    await tester.pumpAndSettle();
    expect(find.byType(PatrimoniosTab), findsOneWidget);
    expect(find.text('Notebook Lenovo ThinkPad L14'), findsOneWidget);

    // Tap Docentes tab
    await tester.tap(find.text('Docentes'));
    await tester.pumpAndSettle();
    expect(find.byType(DocentesTab), findsOneWidget);
    expect(find.text('Prof. Marcos Andrade'), findsOneWidget);
  });
}
