import 'package:flutter_test/flutter_test.dart';
import 'package:shop_demo/app/theme/app_radius.dart';

void main() {
  group('AppRadius', () {
    test('xs is 4px', () => expect(AppRadius.xs, 4.0));
    test('sm is 8px', () => expect(AppRadius.sm, 8.0));
    test('md is 14px', () => expect(AppRadius.md, 14.0));
    test('lg is 20px', () => expect(AppRadius.lg, 20.0));
    test('xl is 32px', () => expect(AppRadius.xl, 32.0));
    test('full is 9999px (pill shape)', () => expect(AppRadius.full, 9999.0));
  });
}
