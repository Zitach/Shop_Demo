import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_demo/app/theme/app_typography.dart';

void main() {
  group('AppTypography', () {
    test('fontFamily is Inter', () {
      expect(AppTypography.fontFamily, 'Inter');
    });

    test('displayXl is 28px / w700', () {
      expect(AppTypography.displayXl.fontSize, 28.0);
      expect(AppTypography.displayXl.fontWeight, FontWeight.w700);
    });

    test('bodySm is 14px / w400', () {
      expect(AppTypography.bodySm.fontSize, 14.0);
      expect(AppTypography.bodySm.fontWeight, FontWeight.w400);
    });

    test('ratingDisplay is 64px / w700 (largest in system)', () {
      expect(AppTypography.ratingDisplay.fontSize, 64.0);
      expect(AppTypography.ratingDisplay.fontWeight, FontWeight.w700);
    });

    test('buttonMd is 16px / w500', () {
      expect(AppTypography.buttonMd.fontSize, 16.0);
      expect(AppTypography.buttonMd.fontWeight, FontWeight.w500);
    });
  });
}
