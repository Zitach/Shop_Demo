import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_demo/shared/widgets/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('primary button shows label and responds to tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButton.primary(
            label: 'Reserve',
            onTap: () => tapped = true,
          ),
        ),
      ));

      expect(find.text('Reserve'), findsOneWidget);
      await tester.tap(find.text('Reserve'));
      expect(tapped, isTrue);
    });

    testWidgets('secondary button has outlined style', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButton.secondary(label: 'Save', onTap: () {}),
        ),
      ));

      final outlinedBtn = tester.widget<OutlinedButton>(find.byType(OutlinedButton));
      expect(outlinedBtn, isNotNull);
    });

    testWidgets('disabled button does not respond to tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AppButton.primary(
            label: 'Reserve',
            onTap: () => tapped = true,
            enabled: false,
          ),
        ),
      ));

      await tester.tap(find.text('Reserve'));
      expect(tapped, isFalse);
    });
  });
}
