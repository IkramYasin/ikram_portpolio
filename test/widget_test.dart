import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ikram_portpolio/main.dart';

void main() {
  testWidgets('portfolio page renders primary content', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const PortfolioApp());

    expect(find.text('AVAILABLE FOR LEARNING & COLLABORATION'), findsOneWidget);
    expect(find.text('Ikram AI'), findsOneWidget);
  });
}
