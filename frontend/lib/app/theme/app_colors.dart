import 'package:flutter/material.dart';

/// Airbnb design system color tokens extracted from DESIGN.md.
/// Single accent color: Rausch (#ff385c) carries every primary CTA.
abstract final class AppColors {
  // ── Brand & Accent ──────────────────────────────────────
  static const Color primary = Color(0xFFFF385C);          // Rausch
  static const Color primaryActive = Color(0xFFE00B41);    // Press state
  static const Color primaryDisabled = Color(0xFFFFD1DA);  // Disabled CTA
  static const Color luxe = Color(0xFF460479);             // Luxe sub-brand
  static const Color plus = Color(0xFF92174D);             // Plus sub-brand

  // ── Surface ─────────────────────────────────────────────
  static const Color canvas = Color(0xFFFFFFFF);           // Page floor
  static const Color surfaceSoft = Color(0xFFF7F7F7);      // Lightest fill
  static const Color surfaceStrong = Color(0xFFF2F2F2);    // Icon-button bg

  // ── Hairlines & Borders ─────────────────────────────────
  static const Color hairline = Color(0xFFDDDDDD);         // Default 1px border
  static const Color hairlineSoft = Color(0xFFEBEBEB);     // Lighter divider
  static const Color borderStrong = Color(0xFFC1C1C1);     // Disabled outline

  // ── Text ────────────────────────────────────────────────
  static const Color ink = Color(0xFF222222);              // Primary text
  static const Color body = Color(0xFF3F3F3F);             // Running text
  static const Color muted = Color(0xFF6A6A6A);            // Subtitles
  static const Color mutedSoft = Color(0xFF929292);        // Disabled text

  // ── Semantic ────────────────────────────────────────────
  static const Color errorText = Color(0xFFC13515);        // Form errors
  static const Color errorTextHover = Color(0xFFB32505);   // Error hover
  static const Color legalLink = Color(0xFF428BFF);        // Legal links
  static const Color starRating = Color(0xFF222222);       // Same as ink

  // ── Surface Overlays ────────────────────────────────────
  static const Color onPrimary = Color(0xFFFFFFFF);        // White on Rausch
  static const Color onDark = Color(0xFFFFFFFF);           // White on dark
  static const Color scrim = Color(0x80000000);            // 50% black modal
}
