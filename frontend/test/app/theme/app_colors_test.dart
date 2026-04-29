import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_demo/app/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    test('primary is Rausch #ff385c', () {
      expect(AppColors.primary, const Color(0xFFFF385C));
    });

    test('primaryActive is darker Rausch', () {
      expect(AppColors.primaryActive, const Color(0xFFE00B41));
    });

    test('canvas is white', () {
      expect(AppColors.canvas, const Color(0xFFFFFFFF));
    });

    test('ink is near-black', () {
      expect(AppColors.ink, const Color(0xFF222222));
    });

    test('hairline is light gray', () {
      expect(AppColors.hairline, const Color(0xFFDDDDDD));
    });
  });
}
