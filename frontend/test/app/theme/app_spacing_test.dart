import 'package:flutter_test/flutter_test.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    test('base unit is 4px', () {
      expect(AppSpacing.xs, 4.0);
    });

    test('xs is half of sm', () {
      expect(AppSpacing.xs, AppSpacing.sm / 2);
    });

    test('section is 64px', () {
      expect(AppSpacing.section, 64.0);
    });

    test('spacing scale is monotonically increasing', () {
      final values = [
        AppSpacing.xxs, AppSpacing.xs, AppSpacing.sm,
        AppSpacing.md, AppSpacing.base, AppSpacing.lg,
        AppSpacing.xl, AppSpacing.xxl, AppSpacing.section,
      ];
      for (int i = 1; i < values.length; i++) {
        expect(values[i], greaterThan(values[i - 1]),
            reason: '${values[i]} should be > ${values[i - 1]}');
      }
    });
  });
}
