import 'package:flutter/material.dart';

/// Airbnb typography system using Inter (open-source substitute for Cereal).
/// Display weights sit at 500-700, body at 400. Modest weight is intentional —
/// the system trusts photography for visual heft.
abstract final class AppTypography {
  static const String fontFamily = 'Inter';

  static const TextStyle ratingDisplay = TextStyle(
    fontFamily: fontFamily, fontSize: 64, fontWeight: FontWeight.w700,
    height: 1.1, letterSpacing: -1.0,
  );
  static const TextStyle displayXl = TextStyle(
    fontFamily: fontFamily, fontSize: 28, fontWeight: FontWeight.w700,
    height: 1.43, letterSpacing: 0,
  );
  static const TextStyle displayLg = TextStyle(
    fontFamily: fontFamily, fontSize: 22, fontWeight: FontWeight.w500,
    height: 1.18, letterSpacing: -0.44,
  );
  static const TextStyle displayMd = TextStyle(
    fontFamily: fontFamily, fontSize: 21, fontWeight: FontWeight.w700,
    height: 1.43, letterSpacing: 0,
  );
  static const TextStyle displaySm = TextStyle(
    fontFamily: fontFamily, fontSize: 20, fontWeight: FontWeight.w600,
    height: 1.20, letterSpacing: -0.18,
  );
  static const TextStyle titleMd = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w600,
    height: 1.25, letterSpacing: 0,
  );
  static const TextStyle titleSm = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500,
    height: 1.25, letterSpacing: 0,
  );
  static const TextStyle bodyMd = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w400,
    height: 1.5, letterSpacing: 0,
  );
  static const TextStyle bodySm = TextStyle(
    fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w400,
    height: 1.43, letterSpacing: 0,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500,
    height: 1.29, letterSpacing: 0,
  );
  static const TextStyle captionSm = TextStyle(
    fontFamily: fontFamily, fontSize: 13, fontWeight: FontWeight.w400,
    height: 1.23, letterSpacing: 0,
  );
  static const TextStyle badge = TextStyle(
    fontFamily: fontFamily, fontSize: 11, fontWeight: FontWeight.w600,
    height: 1.18, letterSpacing: 0,
  );
  static const TextStyle microLabel = TextStyle(
    fontFamily: fontFamily, fontSize: 12, fontWeight: FontWeight.w700,
    height: 1.33, letterSpacing: 0,
  );
  static const TextStyle uppercaseTag = TextStyle(
    fontFamily: fontFamily, fontSize: 10, fontWeight: FontWeight.w700,
    height: 1.25, letterSpacing: 0.32,
  );
  static const TextStyle buttonMd = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w500,
    height: 1.25, letterSpacing: 0,
  );
  static const TextStyle buttonSm = TextStyle(
    fontFamily: fontFamily, fontSize: 14, fontWeight: FontWeight.w500,
    height: 1.29, letterSpacing: 0,
  );
  static const TextStyle navLink = TextStyle(
    fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.w600,
    height: 1.25, letterSpacing: 0,
  );
}
