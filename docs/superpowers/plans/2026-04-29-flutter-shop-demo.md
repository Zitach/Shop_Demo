# Flutter Airbnb-Style Shop Demo — Full Implementation Plan

> **For agentic workers:** REQUIRED: Use superpowers:subagent-driven-development (if subagents available) or superpowers:executing-plans to implement this plan. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a full-stack, cross-platform e-commerce demo with an Airbnb-inspired design language — Flutter frontend, Dart Frog backend, PostgreSQL database.

**Architecture:** Clean Architecture with feature-first organization. Each feature (auth, home, listing, search, booking, profile) is a self-contained module with its own data/domain/presentation layers. Riverpod manages state, GoRouter handles navigation, and Dio connects to a Dart Frog REST API backed by PostgreSQL via Drift ORM.

**Tech Stack:**
- **Frontend:** Flutter 3.x, Dart 3.x, Riverpod 2.x, GoRouter, Dio, Hive, flutter_screenutil, cached_network_image, freezed, json_serializable
- **Backend:** Dart Frog, Drift ORM (`drift_postgres`), PostgreSQL, dart_jsonwebtoken (JWT)
- **DevOps:** Docker Compose (PostgreSQL), GitHub Actions (CI)
- **Design:** Inter font (open-source substitute for Airbnb Cereal), Airbnb design tokens from DESIGN.md
- **i18n:** `flutter_localizations` + ARB files (English / Chinese bilingual)

**Parallelizable Tasks (for subagent-driven development):**
- Tasks 1.2–1.5 (color, spacing, radius, typography) — all independent
- Tasks 2.3–2.5 (mock data, providers, search bar) — partially independent
- Tasks 4.4–4.6 (auth, listings, bookings backend) — independent after Task 4.3

**Spec Document:** `DESIGN.md` (Airbnb design system extraction)

---

## File Map

Before diving into tasks, here is the complete file tree this plan will produce. Each file has one clear responsibility.

### Frontend (`frontend/`)

```
frontend/
├── lib/
│   ├── main.dart                              # App entry point
│   ├── app/
│   │   ├── app.dart                           # MaterialApp.router with theme + router
│   │   ├── router/
│   │   │   └── app_router.dart                # GoRouter route definitions
│   │   └── theme/
│   │       ├── app_theme.dart                 # ThemeData factory
│   │       ├── app_colors.dart                # Color tokens from DESIGN.md
│   │       ├── app_typography.dart            # TextTheme with Inter
│   │       ├── app_spacing.dart               # SpacingScale (4px base)
│   │       └── app_radius.dart                # BorderRadius tokens
│   ├── l10n/                                    # Internationalization
│   │   ├── arb/
│   │   │   ├── intl_en.arb                     # English strings
│   │   │   └── intl_zh.arb                     # Chinese strings
│   │   ├── app_localizations.dart              # Generated (by intl_generator)
│   ├── core/
│   │   ├── network/
│   │   │   ├── api_client.dart                # Dio singleton + interceptors
│   │   │   └── api_exception.dart             # Typed API exceptions
│   │   ├── storage/
│   │   │   └── local_storage.dart             # Hive box wrapper
│   │   ├── utils/
│   │   │   ├── extensions.dart                # BuildContext, String, num extensions
│   │   │   └── formatters.dart                # Locale-aware price/date formatters
│   │   └── constants/
│   │       └── app_constants.dart             # API base URL, storage keys
│   ├── shared/
│   │   ├── widgets/
│   │   │   ├── app_button.dart                # Primary / Secondary / Tertiary buttons
│   │   │   ├── app_text_field.dart            # Styled text input
│   │   │   ├── app_rating.dart                # Star rating (ink color, not gold)
│   │   │   ├── photo_carousel.dart            # Swipeable image PageView with dots
│   │   │   ├── skeleton_loader.dart           # Shimmer placeholder
│   │   │   ├── error_display.dart             # Error state with retry button
│   │   │   └── language_switcher.dart         # Globe icon → EN/ZH toggle
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   │   ├── models/
│   │   │   │   │   ├── user_model.dart        # UserModel (JSON serializable)
│   │   │   │   │   └── auth_response.dart     # Token + user response
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── domain/
│   │   │   │   ├── entities/
│   │   │   │   │   └── user.dart              # Pure domain entity
│   │   │   │   └── repositories/
│   │   │   │       └── auth_repository.dart   # Abstract interface
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── login_page.dart
│   │   │       │   └── register_page.dart
│   │   │       ├── widgets/
│   │   │       │   └── social_login_button.dart
│   │   │       └── providers/
│   │   │           └── auth_provider.dart     # Riverpod providers
│   │   ├── home/
│   │   │   ├── data/
│   │   │   │   ├── home_repository.dart       # Repository (mock → API swap in Chunk 5)
│   │   │   │   └── home_mock_data.dart        # Mock JSON data
│   │   │   ├── domain/
│   │   │   │   ├── category.dart              # Entity + data carrier
│   │   │   │   └── listing_card.dart           # Entity + data carrier
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── home_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── search_bar_pill.dart       # Airbnb-style pill search
│   │   │       │   ├── category_strip.dart        # Horizontal scrolling categories
│   │   │       │   ├── listing_card.dart          # Photo-first card with carousel
│   │   │       │   ├── guest_favorite_badge.dart  # Floating badge overlay
│   │   │       │   └── (removed — absorbed into HomePage as SliverGrid)
│   │   │       └── providers/
│   │   │           └── home_provider.dart
│   │   ├── listing/
│   │   │   ├── data/
│   │   │   │   ├── listing_repository.dart     # Repository (mock → API swap in Chunk 5)
│   │   │   │   └── listing_mock_data.dart      # Mock JSON data
│   │   │   ├── domain/
│   │   │   │   ├── listing_detail.dart          # Entity + data carrier
│   │   │   │   ├── review.dart
│   │   │   │   └── amenity.dart
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   └── listing_detail_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── photo_banner.dart          # Full-width image gallery
│   │   │       │   ├── rating_display_card.dart   # 64px rating number
│   │   │       │   ├── amenity_list.dart          # Icon + label rows
│   │   │       │   ├── host_card.dart             # Seller info card
│   │   │       │   ├── reviews_section.dart       # 2-column review grid
│   │   │       │   └── reservation_card.dart      # Sticky booking sidebar
│   │   │       └── providers/
│   │   │           └── listing_provider.dart
│   │   ├── search/
│   │   │   ├── data/
│   │   │   │   └── search_repository.dart       # Repository (mock → API swap in Chunk 5)
│   │   │   ├── domain/
│   │   │   │   └── search_filter.dart           # Entity + data carrier
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── search_page.dart
│   │   │       │   └── search_results_page.dart
│   │   │       ├── widgets/
│   │   │       │   ├── search_overlay.dart        # Full-screen search on mobile
│   │   │       │   ├── date_range_picker.dart     # Custom Airbnb-style calendar
│   │   │       │   ├── guest_counter.dart         # Increment/decrement stepper
│   │   │       │   └── filter_chip_bar.dart       # Horizontal filter chips
│   │   │       └── providers/
│   │   │           └── search_provider.dart
│   │   ├── booking/
│   │   │   ├── data/
│   │   │   │   └── booking_repository.dart      # Repository (mock → API swap in Chunk 5)
│   │   │   ├── domain/
│   │   │   │   └── booking.dart                 # Entity + data carrier
│   │   │   └── presentation/
│   │   │       ├── pages/
│   │   │       │   ├── booking_page.dart
│   │   │       │   └── booking_confirmation_page.dart
│   │   │       ├── widgets/
│   │   │       │   └── fee_breakdown.dart         # Price + fees + total
│   │   │       └── providers/
│   │   │           └── booking_provider.dart
│   │   └── profile/
│   │       ├── data/
│   │       │   └── profile_repository.dart      # Repository
│   │       ├── domain/
│   │       └── presentation/
│   │           ├── pages/
│   │           │   ├── profile_page.dart
│   │           │   ├── my_bookings_page.dart
│   │           │   └── favorites_page.dart
│   │           └── providers/
│   │               └── profile_provider.dart
├── test/
│   ├── features/
│   │   ├── home/
│   │   │   └── widgets/
│   │   │       └── listing_card_test.dart
│   │   └── listing/
│   │       └── widgets/
│   │           └── rating_display_card_test.dart
│   └── shared/
│       └── widgets/
│           └── app_button_test.dart
├── pubspec.yaml
└── analysis_options.yaml
```

### Backend (`backend/`)

```
backend/
├── routes/
│   ├── index.dart                             # GET / — health check
│   └── api/
│       ├── auth/
│       │   ├── login.dart                     # POST /api/auth/login
│       │   ├── register.dart                  # POST /api/auth/register
│       │   └── refresh.dart                   # POST /api/auth/refresh
│       ├── listings/
│       │   ├── index.dart                     # GET /api/listings?page=&limit=
│       │   ├── [id].dart                      # GET /api/listings/:id
│       │   └── search.dart                    # GET /api/listings/search?q=&category=&...
│       ├── categories/
│       │   └── index.dart                     # GET /api/categories
│       ├── bookings/
│       │   ├── index.dart                     # POST /api/bookings
│       │   └── [id].dart                      # GET /api/bookings/:id
│       ├── reviews/
│       │   └── [listingId].dart               # GET /api/reviews/:listingId
│       └── user/
│           ├── profile.dart                   # GET/PUT /api/user/profile
│           └── favorites.dart                 # GET/POST/DELETE /api/user/favorites
├── lib/
│   ├── middleware/
│   │   ├── auth_middleware.dart                # JWT verification
│   │   ├── cors_middleware.dart                # CORS headers
│   │   └── error_handler.dart                 # Global error handler
│   ├── models/
│   │   ├── user.dart
│   │   ├── listing.dart
│   │   ├── booking.dart
│   │   ├── review.dart
│   │   └── category.dart
│   ├── database/
│   │   ├── database_context.dart              # Drift database definition
│   │   ├── tables/
│   │   │   ├── users_table.dart
│   │   │   ├── listings_table.dart
│   │   │   ├── bookings_table.dart
│   │   │   ├── reviews_table.dart
│   │   │   ├── categories_table.dart
│   │   │   ├── images_table.dart
│   │   │   ├── amenities_table.dart
│   │   │   └── favorites_table.dart
│   │   └── daos/
│   │       ├── user_dao.dart
│   │       ├── listing_dao.dart
│   │       ├── booking_dao.dart
│   │       └── review_dao.dart
│   └── services/
│       ├── auth_service.dart
│       ├── listing_service.dart
│       ├── booking_service.dart
│       └── search_service.dart
├── test/
│   └── routes/
│       ├── auth_test.dart
│       └── listings_test.dart
├── pubspec.yaml
├── dart_frog.yaml
└── Dockerfile
```

### Root

```
docker-compose.yml                             # PostgreSQL + backend
```

---

## Chunk 1: Project Scaffold + Design System

This chunk establishes the foundation: Flutter project, design tokens from DESIGN.md, and the core theme system. Every subsequent chunk depends on this.

### Task 1.1: Initialize Flutter Project

**Files:**
- Create: `frontend/pubspec.yaml`
- Create: `frontend/analysis_options.yaml`
- Create: `frontend/lib/main.dart`

- [ ] **Step 1: Create the Flutter project**

```bash
cd /Users/zhouquan/Desktop/Shop_Demo
flutter create frontend --org com.shopdemo --platforms=ios,android,web,macos,windows,linux
```

Expected: Project created successfully with all platform directories.

- [ ] **Step 2: Replace pubspec.yaml with dependencies**

```yaml
# frontend/pubspec.yaml
name: shop_demo
description: Airbnb-style e-commerce demo built with Flutter.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.2.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State Management
  flutter_riverpod: ^2.5.1

  # Routing
  go_router: ^14.2.0

  # Network
  dio: ^5.4.3+1

  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0

  # UI
  flutter_screenutil: ^5.9.3
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  intl: ^0.19.0

  # Serialization
  freezed_annotation: ^2.4.1
  json_annotation: ^4.9.0

  # Utils
  equatable: ^2.0.5
  uuid: ^4.4.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

  # Code Generation
  build_runner: ^2.4.9
  freezed: ^2.5.2
  json_serializable: ^6.8.0
  intl_utils: ^2.8.7

  # Testing
  mocktail: ^1.0.4

flutter:
  uses-material-design: true

  fonts:
    - family: Inter
      fonts:
	        - asset: assets/fonts/Inter-Regular.ttf
	          weight: 400
	        - asset: assets/fonts/Inter-Medium.ttf
	          weight: 500
	        - asset: assets/fonts/Inter-Bold.ttf
	          weight: 700
```

- [ ] **Step 3: Download Inter font files**

```bash
cd /Users/zhouquan/Desktop/Shop_Demo/frontend
mkdir -p assets/fonts
# Download Inter font from Google Fonts
curl -L -o /tmp/Inter.zip "https://fonts.google.com/download?family=Inter"
unzip /tmp/Inter.zip -d /tmp/Inter
cp /tmp/Inter/static/Inter-*.ttf assets/fonts/
```

Expected: Inter font files present in `assets/fonts/`.

- [ ] **Step 4: Set analysis_options.yaml**

```yaml
# frontend/analysis_options.yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - '**/*.g.dart'
    - '**/*.freezed.dart'

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_declarations: true
    avoid_print: true
    prefer_single_quotes: true
```

- [ ] **Step 5: Create minimal main.dart**

```dart
// frontend/lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ShopApp()));
}

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop Demo',
      home: const Scaffold(
        body: Center(child: Text('Shop Demo')),
      ),
    );
  }
}
```

- [ ] **Step 6: Verify project builds**

```bash
cd /Users/zhouquan/Desktop/Shop_Demo/frontend
flutter pub get
flutter analyze
```

Expected: No errors. Warnings about unused imports are acceptable.

- [ ] **Step 7: Commit**

```bash
git add frontend/
git commit -m "feat: initialize Flutter project with dependencies"
```

---

### Task 1.2: Design System — Color Tokens

Translate the Airbnb color tokens from DESIGN.md into Flutter constants.

**Files:**
- Create: `frontend/lib/app/theme/app_colors.dart`
- Test: `frontend/test/app/theme/app_colors_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
// frontend/test/app/theme/app_colors_test.dart
import 'package:flutter/material.dart';
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
```

- [ ] **Step 2: Run test to verify it fails**

```bash
cd /Users/zhouquan/Desktop/Shop_Demo/frontend
flutter test test/app/theme/app_colors_test.dart
```

Expected: FAIL — `app_colors.dart` does not exist.

- [ ] **Step 3: Implement AppColors**

```dart
// frontend/lib/app/theme/app_colors.dart
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
```

- [ ] **Step 4: Run test to verify it passes**

```bash
flutter test test/app/theme/app_colors_test.dart
```

Expected: All 5 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/app/theme/app_colors.dart frontend/test/app/theme/app_colors_test.dart
git commit -m "feat: add Airbnb color tokens from DESIGN.md"
```

---

### Task 1.3: Design System — Spacing Scale

**Files:**
- Create: `frontend/lib/app/theme/app_spacing.dart`
- Test: `frontend/test/app/theme/app_spacing_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
// frontend/test/app/theme/app_spacing_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    test('base unit is 4px', () {
      expect(AppSpacing.base, 4.0);
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
            reason: '${_name(values[i])} should be > ${_name(values[i - 1])}');
      }
    });
  });
}

String _name(double v) => v.toString();
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/app/theme/app_spacing_test.dart
```

Expected: FAIL — `app_spacing.dart` does not exist.

- [ ] **Step 3: Implement AppSpacing**

```dart
// frontend/lib/app/theme/app_spacing.dart

/// Airbnb spacing system. Base unit: 4px.
abstract final class AppSpacing {
  static const double xxs = 2.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double base = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double section = 64.0;
}
```

- [ ] **Step 4: Run test to verify it passes**

```bash
flutter test test/app/theme/app_spacing_test.dart
```

Expected: All 4 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/app/theme/app_spacing.dart frontend/test/app/theme/app_spacing_test.dart
git commit -m "feat: add Airbnb spacing scale (4px base)"
```

---

### Task 1.4: Design System — Border Radius Tokens

**Files:**
- Create: `frontend/lib/app/theme/app_radius.dart`
- Test: `frontend/test/app/theme/app_radius_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
// frontend/test/app/theme/app_radius_test.dart
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
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/app/theme/app_radius_test.dart
```

Expected: FAIL.

- [ ] **Step 3: Implement AppRadius**

```dart
// frontend/lib/app/theme/app_radius.dart

/// Airbnb border radius tokens. The shape language is soft — no hard corners
/// except the body grid itself.
abstract final class AppRadius {
  static const double none = 0.0;
  static const double xs = 4.0;
  static const double sm = 8.0;    // Buttons
  static const double md = 14.0;   // Property cards
  static const double lg = 20.0;
  static const double xl = 32.0;   // Category strip
  static const double full = 9999.0; // Pill shapes, circles
}
```

- [ ] **Step 4: Run test to verify it passes**

```bash
flutter test test/app/theme/app_radius_test.dart
```

Expected: All 6 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/app/theme/app_radius.dart frontend/test/app/theme/app_radius_test.dart
git commit -m "feat: add Airbnb border radius tokens"
```

---

### Task 1.5: Design System — Typography

**Files:**
- Create: `frontend/lib/app/theme/app_typography.dart`
- Test: `frontend/test/app/theme/app_typography_test.dart`

- [ ] **Step 1: Write the failing test**

```dart
// frontend/test/app/theme/app_typography_test.dart
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
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/app/theme/app_typography_test.dart
```

Expected: FAIL.

- [ ] **Step 3: Implement AppTypography**

```dart
// frontend/lib/app/theme/app_typography.dart
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
```

- [ ] **Step 4: Run test to verify it passes**

```bash
flutter test test/app/theme/app_typography_test.dart
```

Expected: All 5 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/app/theme/app_typography.dart frontend/test/app/theme/app_typography_test.dart
git commit -m "feat: add Airbnb typography system with Inter font"
```

---

### Task 1.6: Design System — ThemeData Factory

Wire colors, typography, spacing, and radius into a Flutter `ThemeData`.

**Files:**
- Create: `frontend/lib/app/theme/app_theme.dart`
- Modify: `frontend/lib/app/theme/app_theme.dart`

- [ ] **Step 1: Implement AppTheme**

```dart
// frontend/lib/app/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

/// Builds a Flutter ThemeData matching the Airbnb design system.
abstract final class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.canvas,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        surface: AppColors.canvas,
        onSurface: AppColors.ink,
        error: AppColors.errorText,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayXl,
        displayMedium: AppTypography.displayMd,
        displaySmall: AppTypography.displaySm,
        headlineLarge: AppTypography.displayLg,
        headlineMedium: AppTypography.titleMd,
        headlineSmall: AppTypography.titleSm,
        bodyLarge: AppTypography.bodyMd,
        bodyMedium: AppTypography.bodySm,
        bodySmall: AppTypography.captionSm,
        labelLarge: AppTypography.buttonMd,
        labelMedium: AppTypography.buttonSm,
        labelSmall: AppTypography.badge,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.canvas,
        foregroundColor: AppColors.ink,
        elevation: 0,
        scrolledUnderElevation: 0.02,
        titleTextStyle: AppTypography.navLink.copyWith(color: AppColors.ink),
      ),
      cardTheme: CardTheme(
        color: AppColors.canvas,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14), // {rounded.md}
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: AppTypography.buttonMd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // {rounded.sm}
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          minimumSize: const Size(0, 48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          textStyle: AppTypography.buttonMd,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: AppColors.ink),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
          minimumSize: const Size(0, 48),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.canvas,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.hairline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.hairline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.ink, width: 2),
        ),
        hintStyle: AppTypography.bodyMd.copyWith(color: AppColors.muted),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.hairline,
        thickness: 1,
        space: 0,
      ),
    );
  }
}
```

- [ ] **Step 2: Verify it compiles**

```bash
flutter test --no-pub 2>&1 | head -20
# Or just check for compile errors:
dart analyze lib/app/theme/
```

Expected: No analysis errors.

- [ ] **Step 3: Commit**

```bash
git add frontend/lib/app/theme/app_theme.dart
git commit -m "feat: wire up ThemeData from design tokens"
```

---

### Task 1.7: Core Infrastructure — Constants, Extensions, Formatters

**Files:**
- Create: `frontend/lib/core/constants/app_constants.dart`
- Create: `frontend/lib/core/utils/extensions.dart`
- Create: `frontend/lib/core/utils/formatters.dart`

- [ ] **Step 1: Create app_constants.dart**

```dart
// frontend/lib/core/constants/app_constants.dart

abstract final class AppConstants {
  static const String appName = 'Shop Demo';
  static const String apiBaseUrl = 'http://localhost:8080';
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userKey = 'cached_user';
  static const int defaultPageSize = 20;
}
```

- [ ] **Step 2: Create extensions.dart**

```dart
// frontend/lib/core/utils/extensions.dart
import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  bool get isMobile => screenWidth < 744;
  bool get isTablet => screenWidth >= 744 && screenWidth < 1128;
  bool get isDesktop => screenWidth >= 1128;
}

extension StringExt on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
```

- [ ] **Step 3: Create formatters.dart**

```dart
// frontend/lib/core/utils/formatters.dart
// NOTE: These formatters will be made locale-aware in Task 1.11 (i18n).
// They will gain a BuildContext parameter for locale detection.
import 'package:intl/intl.dart';

abstract final class PriceFormatter {
  static final _fmt = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
  static final _fmtDecimal = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  static String format(num amount) => _fmt.format(amount);
  static String formatDecimal(num amount) => _fmtDecimal.format(amount);
  static String perNight(num amount) => '${_fmt.format(amount)} night';
  static String total(num amount, int nights) =>
      '${_fmt.format(amount)} x $nights nights = ${_fmt.format(amount * nights)}';
}

abstract final class DateFmt {
  static final _md = DateFormat.MMMd();
  static final _mdy = DateFormat.yMMMd();

  static String monthDay(DateTime d) => _md.format(d);
  static String monthDayYear(DateTime d) => _mdy.format(d);
  static String range(DateTime start, DateTime end) =>
      '${_md.format(start)} – ${_md.format(end)}';
  static int nightsBetween(DateTime start, DateTime end) =>
      end.difference(start).inDays;
}
```

- [ ] **Step 4: Verify compilation**

```bash
dart analyze lib/core/
```

Expected: No errors.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/core/
git commit -m "feat: add core constants, extensions, and formatters"
```

---

### Task 1.8: Core Infrastructure — API Client (Dio)

**Files:**
- Create: `frontend/lib/core/network/api_client.dart`
- Create: `frontend/lib/core/network/api_exception.dart`

- [ ] **Step 1: Implement ApiException**

```dart
// frontend/lib/core/network/api_exception.dart

sealed class ApiException implements Exception {
  final String message;
  final int? statusCode;
  const ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException($statusCode): $message';
}

class NetworkException extends ApiException {
  const NetworkException(super.message) : super(statusCode: null);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException([super.message = 'Unauthorized'])
      : super(statusCode: 401);
}

class ForbiddenException extends ApiException {
  const ForbiddenException([super.message = 'Forbidden'])
      : super(statusCode: 403);
}

class NotFoundException extends ApiException {
  const NotFoundException([super.message = 'Not found'])
      : super(statusCode: 404);
}

class ValidationException extends ApiException {
  final Map<String, List<String>>? errors;
  const ValidationException(super.message, {this.errors})
      : super(statusCode: 422);
}

class ServerException extends ApiException {
  const ServerException([super.message = 'Server error'])
      : super(statusCode: 500);
}
```

- [ ] **Step 2: Implement ApiClient**

```dart
// frontend/lib/core/network/api_client.dart
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import 'api_exception.dart';

class ApiClient {
  late final Dio _dio;

  /// [getToken] is a callback that returns the current auth token (or null).
  /// Wired to LocalStorage from Task 1.9 — no need to wait until Chunk 5.
  ApiClient({String? baseUrl, String? Function()? getToken}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? AppConstants.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.addAll([
      if (getToken != null) _AuthInterceptor(getToken),
      _ErrorInterceptor(),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  Dio get dio => _dio;

  void setToken(String? token) {
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }
}

class _AuthInterceptor extends Interceptor {
  final String? Function() _getToken;

  _AuthInterceptor(this._getToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final message = _extractMessage(err);

    final ApiException exception = switch (statusCode) {
      401 => UnauthorizedException(message),
      403 => ForbiddenException(message),
      404 => NotFoundException(message),
      422 => ValidationException(message),
      500 => ServerException(message),
      _ => err.type == DioExceptionType.connectionTimeout ||
              err.type == DioExceptionType.connectionError
          ? NetworkException('No internet connection')
          : ServerException(message),
    };

    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: exception,
      type: err.type,
      response: err.response,
    ));
  }

  String _extractMessage(DioException err) {
    try {
      final data = err.response?.data;
      if (data is Map<String, dynamic>) return data['message']?.toString() ?? 'Unknown error';
      if (data is String) return data;
    } catch (_) {}
    return err.message ?? 'Unknown error';
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add frontend/lib/core/network/
git commit -m "feat: add Dio API client with typed error handling"
```

---

### Task 1.9: Core Infrastructure — Local Storage (Hive)

**Files:**
- Create: `frontend/lib/core/storage/local_storage.dart`

- [ ] **Step 1: Implement LocalStorage**

```dart
// frontend/lib/core/storage/local_storage.dart
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static const _boxName = 'shop_demo';

  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  // ── Token ─────────────────────────────────────────────
  String? get token => _box.get('token');
  set token(String? value) {
    if (value == null) {
      _box.delete('token');
    } else {
      _box.put('token', value);
    }
  }

  // ── Refresh Token ─────────────────────────────────────
  String? get refreshToken => _box.get('refreshToken');
  set refreshToken(String? value) {
    if (value == null) {
      _box.delete('refreshToken');
    } else {
      _box.put('refreshToken', value);
    }
  }

  // ── Generic ───────────────────────────────────────────
  T? get<T>(String key) => _box.get(key) as T?;
  Future<void> set<T>(String key, T value) => _box.put(key, value);
  Future<void> remove(String key) => _box.delete(key);
  Future<void> clear() => _box.clear();

  bool get isLoggedIn => token != null;
}
```

- [ ] **Step 2: Commit**

```bash
git add frontend/lib/core/storage/local_storage.dart
git commit -m "feat: add Hive local storage wrapper"
```

---

### Task 1.10: App Shell — Router + App Widget

Wire everything together: theme, router, and the app shell.

**Files:**
- Create: `frontend/lib/app/router/app_router.dart`
- Create: `frontend/lib/app/app.dart`
- Modify: `frontend/lib/main.dart`

- [ ] **Step 1: Create app_router.dart**

```dart
// frontend/lib/app/router/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Placeholder pages — will be replaced by real feature pages.
class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, style: Theme.of(context).textTheme.displayMedium)),
    );
  }
}

final goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const _PlaceholderPage('Home'),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const _PlaceholderPage('Search'),
    ),
    GoRoute(
      path: '/listing/:id',
      name: 'listing',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return _PlaceholderPage('Listing $id');
      },
    ),
    GoRoute(
      path: '/booking/:listingId',
      name: 'booking',
      builder: (context, state) {
        final id = state.pathParameters['listingId']!;
        return _PlaceholderPage('Booking $id');
      },
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const _PlaceholderPage('Login'),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const _PlaceholderPage('Register'),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const _PlaceholderPage('Profile'),
    ),
    GoRoute(
      path: '/my-bookings',
      name: 'myBookings',
      builder: (context, state) => const _PlaceholderPage('My Bookings'),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const _PlaceholderPage('Favorites'),
    ),
  ],
);
```

- [ ] **Step 2: Create app.dart**

```dart
// frontend/lib/app/app.dart
import 'package:flutter/material.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shop Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: goRouter,
    );
  }
}
```

- [ ] **Step 3: Update main.dart**

```dart
// frontend/lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const ProviderScope(child: ShopApp()));
}
```

- [ ] **Step 4: Verify the app builds and runs**

```bash
cd /Users/zhouquan/Desktop/Shop_Demo/frontend
flutter run -d chrome --web-port=3000
```

Expected: A white app with placeholder "Home" page, Inter font, Rausch-colored app bar.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/app/ frontend/lib/main.dart
git commit -m "feat: add GoRouter routes and app shell with Airbnb theme"
```

---

### Task 1.11: Internationalization (i18n) — English + Chinese

Set up bilingual support from the start. All user-facing strings go through ARB files. This must happen before Chunk 2 to avoid retrofitting.

**Files:**
- Create: `frontend/l10n/arb/intl_en.arb`
- Create: `frontend/l10n/arb/intl_zh.arb`
- Create: `frontend/l10n/app_localizations.dart` (generated)
- (removed — barrel export unnecessary, import generated file directly)
- Modify: `frontend/lib/app/app.dart` (add localization delegates)
- Modify: `frontend/lib/main.dart` (set default locale)
- Modify: `frontend/lib/core/utils/formatters.dart` (locale-aware formatting)

- [ ] **Step 1: Create English ARB file**

```json
// frontend/l10n/arb/intl_en.arb
{
  "@@locale": "en",
  "appTitle": "Shop Demo",
  "appName": "Shop Demo",

  // ── Navigation ──────────────────────────────────────────
  "navHome": "Home",
  "navSearch": "Search",
  "navFavorites": "Favorites",
  "navProfile": "Profile",

  // ── Search Bar ──────────────────────────────────────────
  "searchWhere": "Where",
  "searchWhen": "When",
  "searchWho": "Who",
  "searchAnywhere": "Anywhere",
  "searchAnyWeek": "Any week",
  "searchAddGuests": "Add guests",
  "searchButton": "Search",

  // ── Categories ──────────────────────────────────────────
  "categoryNew": "NEW",

  // ── Listing Cards ───────────────────────────────────────
  "guestFavorite": "Guest favorite",
  "perNight": "{price} night",
  "@perNight": {
    "placeholders": {
      "price": { "type": "String" }
    }
  },
  "reviewCount": "{count} reviews",
  "@reviewCount": {
    "placeholders": {
      "count": { "type": "int" }
    }
  },

  // ── Listing Detail ──────────────────────────────────────
  "listingHosted": "Hosted by {hostName}",
  "@listingHosted": {
    "placeholders": {
      "hostName": { "type": "String" }
    }
  },
  "superhost": "Superhost",
  "hostingYears": "{count} years hosting",
  "@hostingYears": {
    "placeholders": {
      "count": { "type": "int" }
    }
  },
  "responseRate": "{rate}% response rate",
  "@responseRate": {
    "placeholders": {
      "rate": { "type": "int" }
    }
  },
  "contactHost": "Contact host",
  "showAllAmenities": "Show all {count} amenities",
  "@showAllAmenities": {
    "placeholders": {
      "count": { "type": "int" }
    }
  },
  "whatThisPlaceOffers": "What this place offers",
  "guestFavoriteTitle": "Guest favorite",
  "guestFavoriteSubtitle": "One of the most loved homes on Airbnb",
  "showMore": "Show more",
  "reviewsTitle": "{count} reviews",
  "@reviewsTitle": {
    "placeholders": {
      "count": { "type": "int" }
    }
  },

  // ── Reservation ─────────────────────────────────────────
  "reserve": "Reserve",
  "addDates": "Add dates for prices",
  "checkIn": "Check-in",
  "checkOut": "Checkout",
  "guests": "Guests",
  "adults": "Adults",
  "children": "Children",
  "infants": "Infants",
  "nights": "{count} nights",
  "@nights": {
    "placeholders": {
      "count": { "type": "int" }
    }
  },
  "cleaningFee": "Cleaning fee",
  "serviceFee": "Service fee",
  "total": "Total",
  "beforeTaxes": "Before taxes",

  // ── Booking ─────────────────────────────────────────────
  "bookingConfirm": "Confirm and pay",
  "bookingSuccess": "Booking confirmed!",
  "bookingDetails": "Booking details",
  "myBookings": "My bookings",
  "bookingStatusPending": "Pending",
  "bookingStatusConfirmed": "Confirmed",
  "bookingStatusCancelled": "Cancelled",
  "bookingStatusCompleted": "Completed",

  // ── Auth ────────────────────────────────────────────────
  "login": "Log in",
  "register": "Sign up",
  "logout": "Log out",
  "email": "Email",
  "password": "Password",
  "confirmPassword": "Confirm password",
  "name": "Name",
  "forgotPassword": "Forgot password?",
  "noAccount": "Don't have an account?",
  "hasAccount": "Already have an account?",
  "loginWithGoogle": "Continue with Google",
  "loginWithApple": "Continue with Apple",

  // ── Profile ─────────────────────────────────────────────
  "profileTitle": "Profile",
  "editProfile": "Edit profile",
  "settings": "Settings",
  "favorites": "Favorites",
  "language": "Language",
  "english": "English",
  "chinese": "中文",

  // ── Home ────────────────────────────────────────────────
  "homeTitle": "Inspiration for your next trip",
  "homeSubtitle": "Discover amazing places to stay",

  // ── Search Results ──────────────────────────────────────
  "searchResults": "Search results",
  "noResults": "No results found",
  "tryDifferentFilters": "Try different filters",
  "priceRange": "Price range",
  "sortBy": "Sort by",
  "sortPriceLow": "Price: Low to High",
  "sortPriceHigh": "Price: High to Low",
  "sortRating": "Rating",
  "sortNewest": "Newest",

  // ── Common ──────────────────────────────────────────────
  "loading": "Loading...",
  "error": "Something went wrong",
  "retry": "Try again",
  "cancel": "Cancel",
  "save": "Save",
  "delete": "Delete",
  "back": "Back",
  "close": "Close",
  "done": "Done",
  "seeAll": "See all",
  "night": "night",
  "perNightShort": "/night"
}
```

- [ ] **Step 2: Create Chinese ARB file**

```json
// frontend/l10n/arb/intl_zh.arb
{
  "@@locale": "zh",
  "appTitle": "商城 Demo",
  "appName": "商城 Demo",

  "navHome": "首页",
  "navSearch": "搜索",
  "navFavorites": "收藏",
  "navProfile": "我的",

  "searchWhere": "地点",
  "searchWhen": "时间",
  "searchWho": "人数",
  "searchAnywhere": "任何地点",
  "searchAnyWeek": "任何时间",
  "searchAddGuests": "添加人数",
  "searchButton": "搜索",

  "categoryNew": "新",

  "guestFavorite": "房客最爱",
  "perNight": "{price}/晚",
  "reviewCount": "{count}条评价",

  "listingHosted": "房东：{hostName}",
  "superhost": "超赞房东",
  "hostingYears": " hosting {count}年",
  "responseRate": "{rate}%回复率",
  "contactHost": "联系房东",
  "showAllAmenities": "查看全部{count}项设施",
  "whatThisPlaceOffers": "房源详情",
  "guestFavoriteTitle": "房客最爱",
  "guestFavoriteSubtitle": "最受欢迎的房源之一",
  "showMore": "查看更多",
  "reviewsTitle": "{count}条评价",

  "reserve": "预订",
  "addDates": "选择日期查看价格",
  "checkIn": "入住",
  "checkOut": "退房",
  "guests": "人数",
  "adults": "成人",
  "children": "儿童",
  "infants": "婴幼儿",
  "nights": "{count}晚",
  "cleaningFee": "清洁费",
  "serviceFee": "服务费",
  "total": "合计",
  "beforeTaxes": "不含税费",

  "bookingConfirm": "确认并支付",
  "bookingSuccess": "预订成功！",
  "bookingDetails": "预订详情",
  "myBookings": "我的预订",
  "bookingStatusPending": "待确认",
  "bookingStatusConfirmed": "已确认",
  "bookingStatusCancelled": "已取消",
  "bookingStatusCompleted": "已完成",

  "login": "登录",
  "register": "注册",
  "logout": "退出登录",
  "email": "邮箱",
  "password": "密码",
  "confirmPassword": "确认密码",
  "name": "姓名",
  "forgotPassword": "忘记密码？",
  "noAccount": "没有账号？",
  "hasAccount": "已有账号？",
  "loginWithGoogle": "使用 Google 登录",
  "loginWithApple": "使用 Apple 登录",

  "profileTitle": "个人中心",
  "editProfile": "编辑资料",
  "settings": "设置",
  "favorites": "收藏夹",
  "language": "语言",
  "english": "English",
  "chinese": "中文",

  "homeTitle": "下一个旅行灵感",
  "homeSubtitle": "发现更多精彩的住宿",

  "searchResults": "搜索结果",
  "noResults": "未找到结果",
  "tryDifferentFilters": "试试其他筛选条件",
  "priceRange": "价格区间",
  "sortBy": "排序",
  "sortPriceLow": "价格从低到高",
  "sortPriceHigh": "价格从高到低",
  "sortRating": "评分最高",
  "sortNewest": "最新上架",

  "loading": "加载中...",
  "error": "出了点问题",
  "retry": "重试",
  "cancel": "取消",
  "save": "保存",
  "delete": "删除",
  "back": "返回",
  "close": "关闭",
  "done": "完成",
  "seeAll": "查看全部",
  "night": "晚",
  "perNightShort": "/晚"
}
```

- [ ] **Step 3: Run code generation**

```bash
cd /Users/zhouquan/Desktop/Shop_Demo/frontend
flutter pub run intl_utils:generate
```

Expected: `lib/l10n/app_localizations.dart` is generated with `AppLocalizations` class.

- [ ] **Step 4: Create convenience barrel export**

```dart

- [ ] **Step 5: Update app.dart with localization delegates**

```dart
// frontend/lib/app/app.dart (updated)
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shop_demo/l10n/app_localizations.dart';
import 'router/app_router.dart';
import 'theme/app_theme.dart';

class ShopApp extends StatelessWidget {
  const ShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shop Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: goRouter,

      // ── i18n ────────────────────────────────────────────
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
      ],
    );
  }
}
```

- [ ] **Step 6: Make formatters locale-aware**

```dart
// frontend/lib/core/utils/formatters.dart (updated)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract final class PriceFormatter {
  // Cache formatters per locale — NumberFormat construction involves locale
  // resolution and should not be repeated on every call.
  static final Map<String, NumberFormat> _cache = {};

  static NumberFormat _fmt(BuildContext context, {int decimalDigits = 0}) {
    final locale = Localizations.localeOf(context).languageCode;
    final realLocale = locale == 'zh' ? 'zh_CN' : 'en_US';
    final key = '$realLocale-$decimalDigits';
    return _cache.putIfAbsent(
      key,
      () => NumberFormat.currency(symbol: '\$', decimalDigits: decimalDigits, locale: realLocale),
    );
  }

  static String format(BuildContext context, num amount) {
    return _fmt(context).format(amount);
  }

  static String formatDecimal(BuildContext context, num amount) {
    return _fmt(context, decimalDigits: 2).format(amount);
  }

  static String perNight(BuildContext context, num amount) {
    final locale = Localizations.localeOf(context).languageCode;
    final price = format(context, amount);
    return locale == 'zh' ? '$price/晚' : '$price night';
  }

  static String total(BuildContext context, num amount, int nights) {
    final locale = Localizations.localeOf(context).languageCode;
    final price = format(context, amount);
    final total = format(context, amount * nights);
    return locale == 'zh'
        ? '$price × $nights晚 = $total'
        : '$price x $nights nights = $total';
  }
}

abstract final class DateFmt {
  static final Map<String, DateFormat> _monthDayCache = {};

  static DateFormat _monthDayFormatter(String locale) {
    final realLocale = locale == 'zh' ? 'zh_CN' : 'en_US';
    return _monthDayCache.putIfAbsent(
      realLocale,
      () => DateFormat.MMMd(realLocale),
    );
  }

  static String monthDay(BuildContext context, DateTime d) {
    final locale = Localizations.localeOf(context).languageCode;
    return _monthDayFormatter(locale).format(d);
  }

  static String range(BuildContext context, DateTime start, DateTime end) {
    return '${monthDay(context, start)} – ${monthDay(context, end)}';
  }

  static int nightsBetween(DateTime start, DateTime end) =>
      end.difference(start).inDays;
}
```

- [ ] **Step 7: Add language switcher widget**

```dart
// frontend/lib/shared/widgets/language_switcher.dart
import 'package:flutter/material.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final current = Localizations.localeOf(context).languageCode;
    final l10n = AppLocalizations.of(context);

    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.language, size: 20),
      onSelected: (locale) {
        // This will be wired to a locale provider in the next task.
        // For now, rebuild the app with the new locale.
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: const Locale('en'),
          child: Row(
            children: [
              if (current == 'en') const Icon(Icons.check, size: 16),
              if (current == 'en') const SizedBox(width: 8),
              Text(l10n.english),
            ],
          ),
        ),
        PopupMenuItem(
          value: const Locale('zh'),
          child: Row(
            children: [
              if (current == 'zh') const Icon(Icons.check, size: 16),
              if (current == 'zh') const SizedBox(width: 8),
              Text(l10n.chinese),
            ],
          ),
        ),
      ],
    );
  }
}
```

- [ ] **Step 8: Add locale state provider**

```dart
// frontend/lib/app/providers/locale_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/core/storage/local_storage.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref.watch(localStorageProvider));
});

class LocaleNotifier extends StateNotifier<Locale> {
  final LocalStorage _storage;

  LocaleNotifier(this._storage) : super(const Locale('en')) {
    final saved = _storage.get<String>('locale');
    if (saved != null) state = Locale(saved);
  }

  void setLocale(Locale locale) {
    state = locale;
    _storage.set('locale', locale.languageCode);
  }
}
```

- [ ] **Step 9: Verify localization works**

```bash
flutter run -d chrome --web-port=3000
```

Expected: App loads in English. The LanguageSwitcher popup shows EN/ZH options.

- [ ] **Step 10: Commit**

```bash
git add frontend/l10n/ frontend/lib/app/app.dart frontend/lib/core/utils/formatters.dart frontend/lib/shared/widgets/language_switcher.dart frontend/lib/app/providers/locale_provider.dart
git commit -m "feat: add i18n with English and Chinese bilingual support"
```

**Note:** All subsequent tasks MUST use `AppLocalizations.of(context).someKey` instead of hardcoded strings. The ARB files above cover all strings needed by the entire app. When adding new UI text in later tasks, add the key to both ARB files first.

---

## Chunk 2: Home Page — Airbnb-Style UI Components

This chunk builds the first real screen: the homepage with pill search bar, category strip, and photo-first listing cards. All data comes from mock JSON.

### Task 2.1: Shared Widgets — AppButton

**Files:**
- Create: `frontend/lib/shared/widgets/app_button.dart`
- Test: `frontend/test/shared/widgets/app_button_test.dart`

- [ ] **Step 1: Write the widget test**

```dart
// frontend/test/shared/widgets/app_button_test.dart
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
```

- [ ] **Step 2: Run test to verify it fails**

```bash
flutter test test/shared/widgets/app_button_test.dart
```

Expected: FAIL.

- [ ] **Step 3: Implement AppButton**

```dart
// frontend/lib/shared/widgets/app_button.dart
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_typography.dart';

enum _AppButtonType { primary, secondary, tertiary }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final _AppButtonType _type;
  final bool enabled;
  final IconData? icon;

  const AppButton.primary({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.icon,
  }) : _type = _AppButtonType.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.icon,
  }) : _type = _AppButtonType.secondary;

  const AppButton.tertiary({
    super.key,
    required this.label,
    required this.onTap,
    this.enabled = true,
    this.icon,
  }) : _type = _AppButtonType.tertiary;

  @override
  Widget build(BuildContext context) {
    final effectiveOnTap = enabled ? onTap : null;

    return switch (_type) {
      _AppButtonType.primary => SizedBox(
          height: 48,
          child: ElevatedButton(
            onPressed: effectiveOnTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: enabled ? AppColors.primary : AppColors.primaryDisabled,
              foregroundColor: AppColors.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              textStyle: AppTypography.buttonMd,
            ),
            child: _buildChild(AppColors.onPrimary),
          ),
        ),
      _AppButtonType.secondary => SizedBox(
          height: 48,
          child: OutlinedButton(
            onPressed: effectiveOnTap,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.ink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              side: const BorderSide(color: AppColors.ink),
              textStyle: AppTypography.buttonMd,
            ),
            child: _buildChild(AppColors.ink),
          ),
        ),
      _AppButtonType.tertiary => TextButton(
          onPressed: effectiveOnTap,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.ink,
            textStyle: AppTypography.buttonMd,
          ),
          child: _buildChild(AppColors.ink),
        ),
    };
  }

  Widget _buildChild(Color iconColor) {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: iconColor),
          const SizedBox(width: 8),
          Text(label),
        ],
      );
    }
    return Text(label);
  }
}
```

- [ ] **Step 4: Run test to verify it passes**

```bash
flutter test test/shared/widgets/app_button_test.dart
```

Expected: All 3 tests PASS.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/shared/widgets/app_button.dart frontend/test/shared/widgets/app_button_test.dart
git commit -m "feat: add AppButton (primary/secondary/tertiary) with Airbnb styling"
```

---

### Task 2.2: Shared Widgets — Photo Carousel

The Airbnb listing card has a swipeable image carousel with dot indicators.

**Files:**
- Create: `frontend/lib/shared/widgets/photo_carousel.dart`

- [ ] **Step 1: Implement PhotoCarousel**

```dart
// frontend/lib/shared/widgets/photo_carousel.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';

class PhotoCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double aspectRatio;
  final BorderRadius? borderRadius;
  final List<Widget>? overlays;

  const PhotoCarousel({
    super.key,
    required this.imageUrls,
    this.aspectRatio = 1.0,
    this.borderRadius,
    this.overlays,
  });

  @override
  State<PhotoCarousel> createState() => _PhotoCarouselState();
}

class _PhotoCarouselState extends State<PhotoCarousel> {
  int _current = 0;
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.borderRadius ??
        BorderRadius.circular(AppRadius.md);

    return ClipRRect(
      borderRadius: radius,
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Stack(
          children: [
            // Image pages
            PageView.builder(
              controller: _controller,
              itemCount: widget.imageUrls.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: widget.imageUrls[index],
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(color: AppColors.surfaceSoft),
                  errorWidget: (_, __, ___) => Container(
                    color: AppColors.surfaceSoft,
                    child: const Icon(Icons.broken_image, color: AppColors.muted),
                  ),
                );
              },
            ),

            // Dot indicators (only if >1 image)
            if (widget.imageUrls.length > 1)
              Positioned(
                bottom: 8,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.imageUrls.length,
                    (i) => Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i == _current
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ),

            // Overlays (badges, buttons)
            if (widget.overlays != null) ...widget.overlays!,
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add frontend/lib/shared/widgets/photo_carousel.dart
git commit -m "feat: add PhotoCarousel with dot indicators"
```

---

### Task 2.3: Home Feature — Mock Data

Create realistic mock data for the home page. This lets us build UI without a backend.

**Files:**
- Create: `frontend/lib/features/home/data/home_mock_data.dart`
- Create: `frontend/lib/features/home/domain/category.dart`
- Create: `frontend/lib/features/home/domain/listing_card.dart`
- Create: `frontend/lib/features/home/data/home_repository.dart`

- [ ] **Step 1: Create domain entities**

```dart
// frontend/lib/features/home/domain/category.dart
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String iconUrl;
  final bool isNew;

  const Category({
    required this.id,
    required this.name,
    required this.iconUrl,
    this.isNew = false,
  });

  @override
  List<Object?> get props => [id, name, iconUrl, isNew];
}
```

```dart
// frontend/lib/features/home/domain/listing_card.dart
import 'package:equatable/equatable.dart';

class ListingCard extends Equatable {
  final String id;
  final List<String> imageUrls;
  final String title;
  final String location;
  final String? dateRange;
  final double pricePerNight;
  final double? rating;
  final int reviewCount;
  final bool isGuestFavorite;

  const ListingCard({
    required this.id,
    required this.imageUrls,
    required this.title,
    required this.location,
    this.dateRange,
    required this.pricePerNight,
    this.rating,
    this.reviewCount = 0,
    this.isGuestFavorite = false,
  });

  @override
  List<Object?> get props => [id, title, location, pricePerNight, rating, reviewCount, isGuestFavorite];
}
```

- [ ] **Step 2: Create mock data source**

```dart
// frontend/lib/features/home/data/home_mock_data.dart
import 'package:shop_demo/features/home/domain/entities/category.dart';
import 'package:shop_demo/features/home/domain/entities/listing_card.dart';

/// Mock data for home page. Uses Unsplash CDN for listing images —
/// requires network connectivity or images will show placeholders.
/// For offline development, replace URLs with local asset paths.
abstract final class HomeMockData {
  static const categories = [
    Category(id: 1, name: 'Rooms', iconUrl: 'https://img.icons8.com/ios/32/bedroom.png'),
    Category(id: 2, name: 'Mansions', iconUrl: 'https://img.icons8.com/ios/32/castle.png'),
    Category(id: 3, name: 'Countryside', iconUrl: 'https://img.icons8.com/ios/32/farm.png'),
    Category(id: 4, name: 'Beach', iconUrl: 'https://img.icons8.com/ios/32/beach.png'),
    Category(id: 5, name: 'Cabins', iconUrl: 'https://img.icons8.com/ios/32/cabin.png'),
    Category(id: 6, name: 'Pools', iconUrl: 'https://img.icons8.com/ios/32/swimming.png'),
    Category(id: 7, name: 'Lakefront', iconUrl: 'https://img.icons8.com/ios/32/lake.png'),
    Category(id: 8, name: 'Tiny homes', iconUrl: 'https://img.icons8.com/ios/32/home.png'),
    Category(id: 9, name: 'Treehouses', iconUrl: 'https://img.icons8.com/ios/32/treehouse.png', isNew: true),
    Category(id: 10, name: 'Experiences', iconUrl: 'https://img.icons8.com/ios/32/ticket.png', isNew: true),
  ];

  static const listings = [
    ListingCard(
      id: '1',
      imageUrls: [
        'https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=800',
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
      ],
      title: 'Secluded Treehouse Getaway',
      location: 'Asheville, North Carolina',
      dateRange: 'Nov 12 – 17',
      pricePerNight: 185,
      rating: 4.92,
      reviewCount: 128,
      isGuestFavorite: true,
    ),
    ListingCard(
      id: '2',
      imageUrls: [
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
        'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=800',
      ],
      title: 'Modern Loft in Downtown',
      location: 'Portland, Oregon',
      dateRange: 'Dec 1 – 6',
      pricePerNight: 120,
      rating: 4.78,
      reviewCount: 95,
    ),
    ListingCard(
      id: '3',
      imageUrls: [
        'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
        'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=800',
        'https://images.unsplash.com/photo-1600573472592-401b489a3cdc?w=800',
        'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=800',
      ],
      title: 'Oceanfront Villa with Pool',
      location: 'Malibu, California',
      pricePerNight: 450,
      rating: 4.96,
      reviewCount: 210,
      isGuestFavorite: true,
    ),
    ListingCard(
      id: '4',
      imageUrls: [
        'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?w=800',
        'https://images.unsplash.com/photo-1600210492493-0946911123ea?w=800',
      ],
      title: 'Cozy Mountain Cabin',
      location: 'Gatlinburg, Tennessee',
      dateRange: 'Jan 5 – 10',
      pricePerNight: 95,
      rating: 4.85,
      reviewCount: 342,
    ),
    ListingCard(
      id: '5',
      imageUrls: [
        'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=800',
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800',
      ],
      title: 'Designer Apartment near Eiffel Tower',
      location: 'Paris, France',
      pricePerNight: 275,
      rating: 4.88,
      reviewCount: 156,
    ),
    ListingCard(
      id: '6',
      imageUrls: [
        'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800',
      ],
      title: 'Rustic Farmhouse Retreat',
      location: 'Tuscany, Italy',
      dateRange: 'Mar 15 – 22',
      pricePerNight: 160,
      rating: 4.72,
      reviewCount: 87,
    ),
  ];
}
```

- [ ] **Step 3: Create repository interface + implementation**

```dart
// frontend/lib/features/home/data/home_repository.dart
import 'package:shop_demo/features/home/data/home_mock_data.dart';
import 'package:shop_demo/features/home/domain/category.dart';
import 'package:shop_demo/features/home/domain/listing_card.dart';

/// Single concrete repository — no abstract interface needed for demo scale.
/// In Task 5.1, this file is replaced with an API-backed implementation.
class HomeRepository {
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return HomeMockData.categories;
  }

  Future<List<ListingCard>> getFeaturedListings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return HomeMockData.listings;
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add frontend/lib/features/home/
git commit -m "feat: add home feature domain entities and mock data"
```

---

### Task 2.4: Home Feature — Riverpod Providers

**Files:**
- Create: `frontend/lib/features/home/presentation/providers/home_provider.dart`

- [ ] **Step 1: Implement providers**

```dart
// frontend/lib/features/home/presentation/providers/home_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/features/home/data/repositories/home_repository_impl.dart';
import 'package:shop_demo/features/home/domain/entities/category.dart';
import 'package:shop_demo/features/home/domain/entities/listing_card.dart';
import 'package:shop_demo/features/home/data/home_repository.dart';

// Repository provider (swapped to API-backed impl in Task 5.1)
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

// Categories
final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) {
  return ref.watch(homeRepositoryProvider).getCategories();
});

// Featured listings
final featuredListingsProvider = FutureProvider.autoDispose<List<ListingCard>>((ref) {
  return ref.watch(homeRepositoryProvider).getFeaturedListings();
});
```

- [ ] **Step 2: Commit**

```bash
git add frontend/lib/features/home/presentation/providers/home_provider.dart
git commit -m "feat: add home Riverpod providers"
```

---

### Task 2.5: Home Feature — Search Bar Pill Widget

The signature Airbnb element: a pill-shaped search bar divided into segments.

**Files:**
- Create: `frontend/lib/features/home/presentation/widgets/search_bar_pill.dart`

- [ ] **Step 1: Implement SearchBarPill**

```dart
// frontend/lib/features/home/presentation/widgets/search_bar_pill.dart
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class SearchBarPill extends StatelessWidget {
  final VoidCallback? onTap;
  final String? whereText;
  final String? whenText;
  final String? whoText;

  const SearchBarPill({
    super.key,
    this.onTap,
    this.whereText,
    this.whenText,
    this.whoText,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: AppColors.canvas,
          borderRadius: BorderRadius.circular(AppRadius.full),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 0,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: AppSpacing.lg),
            // Search icon
            const Icon(Icons.search, color: AppColors.ink, size: 24),
            const SizedBox(width: AppSpacing.md),
            // Where
            _Segment(
              label: l10n.searchWhere,
              value: whereText ?? l10n.searchAnywhere,
            ),
            _divider(),
            // When
            _Segment(
              label: l10n.searchWhen,
              value: whenText ?? l10n.searchAnyWeek,
            ),
            _divider(),
            // Who
            _Segment(
              label: l10n.searchWho,
              value: whoText ?? l10n.searchAddGuests,
            ),
            const Spacer(),
            // Search orb (Rausch circle)
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(right: AppSpacing.sm),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.search, color: AppColors.onPrimary, size: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 24,
      color: AppColors.hairline,
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
    );
  }
}

class _Segment extends StatelessWidget {
  final String label;
  final String value;

  const _Segment({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.caption.copyWith(color: AppColors.ink)),
        const SizedBox(height: 2),
        Text(value, style: AppTypography.bodySm.copyWith(color: AppColors.muted)),
      ],
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add frontend/lib/features/home/presentation/widgets/search_bar_pill.dart
git commit -m "feat: add pill-shaped search bar (Airbnb signature element)"
```

---

### Task 2.6: Home Feature — Category Strip

**Files:**
- Create: `frontend/lib/features/home/presentation/widgets/category_strip.dart`

- [ ] **Step 1: Implement CategoryStrip**

```dart
// frontend/lib/features/home/presentation/widgets/category_strip.dart
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/home/domain/entities/category.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class CategoryStrip extends StatelessWidget {
  final List<Category> categories;
  final int? selectedId;
  final ValueChanged<Category>? onSelected;

  const CategoryStrip({
    super.key,
    required this.categories,
    this.selectedId,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.lg),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = cat.id == selectedId;
          return _CategoryItem(
            category: cat,
            isSelected: isSelected,
            onTap: () => onSelected?.call(cat),
          );
        },
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final VoidCallback? onTap;

  const _CategoryItem({
    required this.category,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                _iconForCategory(category.name),
                size: 28,
                color: isSelected ? AppColors.ink : AppColors.muted,
              ),
              if (category.isNew)
                Positioned(
                  top: -6,
                  right: -12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.canvas,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(
                      AppLocalizations.of(context).categoryNew,
                      style: AppTypography.uppercaseTag.copyWith(
                        color: AppColors.ink,
                        fontSize: 7,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            category.name,
            style: AppTypography.buttonSm.copyWith(
              color: isSelected ? AppColors.ink : AppColors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Container(
            height: 2,
            width: 24,
            color: isSelected ? AppColors.ink : Colors.transparent,
          ),
        ],
      ),
    );
  }

  IconData _iconForCategory(String name) {
    return switch (name.toLowerCase()) {
      'rooms' => Icons.hotel,
      'mansions' => Icons.villa,
      'countryside' => Icons.landscape,
      'beach' => Icons.beach_access,
      'cabins' => Icons.cabin,
      'pools' => Icons.pool,
      'lakefront' => Icons.water,
      'tiny homes' => Icons.home,
      'treehouses' => Icons.park,
      'experiences' => Icons.confirmation_num,
      _ => Icons.category,
    };
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add frontend/lib/features/home/presentation/widgets/category_strip.dart
git commit -m "feat: add horizontal category strip with NEW badges"
```

---

### Task 2.7: Home Feature — Listing Card

The photo-first property card: carousel, guest-favorite badge, heart, meta info.

**Files:**
- Create: `frontend/lib/features/home/presentation/widgets/listing_card.dart`
- Create: `frontend/lib/features/home/presentation/widgets/guest_favorite_badge.dart`
- Create: `frontend/lib/features/home/presentation/widgets/listing_grid.dart`

- [ ] **Step 1: Implement GuestFavoriteBadge**

```dart
// frontend/lib/features/home/presentation/widgets/guest_favorite_badge.dart
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class GuestFavoriteBadge extends StatelessWidget {
  const GuestFavoriteBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.canvas,
        borderRadius: BorderRadius.circular(AppRadius.full),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        AppLocalizations.of(context).guestFavorite,
        style: AppTypography.badge.copyWith(color: AppColors.ink),
      ),
    );
  }
}
```

- [ ] **Step 2: Implement ListingCard widget**

```dart
// frontend/lib/features/home/presentation/widgets/listing_card.dart
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/core/utils/formatters.dart';
import 'package:shop_demo/features/home/domain/entities/listing_card.dart';
import 'package:shop_demo/shared/widgets/photo_carousel.dart';
import 'guest_favorite_badge.dart';

class ListingCardWidget extends StatefulWidget {
  final ListingCard listing;
  final VoidCallback? onTap;

  const ListingCardWidget({
    super.key,
    required this.listing,
    this.onTap,
  });

  @override
  State<ListingCardWidget> createState() => _ListingCardWidgetState();
}

class _ListingCardWidgetState extends State<ListingCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isFavorited = false;
  late final AnimationController _heartController;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      lowerBound: 0.6,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _heartController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() => _isFavorited = !_isFavorited);
    if (_isFavorited) {
      _heartController.forward(); // spring bounce on favorite
    } else {
      _heartController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = widget.listing;

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Photo carousel with Hero for listing→detail transition
          Hero(
            tag: 'listing_photo_${l.id}',
            child: PhotoCarousel(
              imageUrls: l.imageUrls,
              aspectRatio: 1.0,
              overlays: [
                // Guest favorite badge (top-left)
                if (l.isGuestFavorite)
                  const Positioned(
                    top: AppSpacing.sm,
                    left: AppSpacing.sm,
                    child: GuestFavoriteBadge(),
                  ),
                // Heart icon with spring animation (top-right)
                Positioned(
                  top: AppSpacing.sm,
                  right: AppSpacing.sm,
                  child: GestureDetector(
                    onTap: _toggleFavorite,
                    child: ScaleTransition(
                      scale: _heartController,
                      child: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited ? AppColors.primary : Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Title row
          Row(
            children: [
              Expanded(
                child: Text(
                  l.title,
                  style: AppTypography.titleMd.copyWith(color: AppColors.ink),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (l.rating != null) ...[
                const Icon(Icons.star, size: 14, color: AppColors.ink),
                const SizedBox(width: 2),
                Text(
                  l.rating!.toStringAsFixed(2),
                  style: AppTypography.bodySm.copyWith(color: AppColors.ink),
                ),
              ],
            ],
          ),
          const SizedBox(height: 2),

          // Location
          Text(
            l.location,
            style: AppTypography.bodySm.copyWith(color: AppColors.muted),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          // Date range
          if (l.dateRange != null) ...[
            const SizedBox(height: 2),
            Text(
              l.dateRange!,
              style: AppTypography.bodySm.copyWith(color: AppColors.muted),
            ),
          ],

          const SizedBox(height: 4),

          // Price
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: PriceFormatter.perNight(context, l.pricePerNight),
                  style: AppTypography.titleMd.copyWith(color: AppColors.ink),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Responsive grid strategy (built into HomePage)**

The responsive listing grid is implemented directly in the HomePage using `SliverList` (mobile) and `SliverGrid` (tablet/desktop) — no separate `ListingGrid` widget. This avoids the `shrinkWrap: true` anti-pattern and preserves lazy rendering inside the `CustomScrollView`.

**Files:**
- Create: `frontend/lib/features/home/presentation/widgets/listing_card.dart`
- Create: `frontend/lib/features/home/presentation/widgets/guest_favorite_badge.dart`

- [ ] **Step 3a: Implement GuestFavoriteBadge** (same as before)
- [ ] **Step 3b: Implement ListingCardWidget** (same as before)
- [ ] **Step 3c: Responsive grid is part of HomePage (Task 2.8)**

- [ ] **Step 4: Commit**

```bash
git add frontend/lib/features/home/presentation/widgets/
git commit -m "feat: add listing card, guest favorite badge, and responsive grid"
```

---

### Task 2.8: Home Feature — Home Page

Assemble all home widgets into the home page.

**Files:**
- Create: `frontend/lib/features/home/presentation/pages/home_page.dart`

- [ ] **Step 1: Implement HomePage**

```dart
// frontend/lib/features/home/presentation/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/features/home/presentation/providers/home_provider.dart';
import 'package:shop_demo/features/home/presentation/widgets/category_strip.dart';
import 'package:shop_demo/features/home/presentation/widgets/listing_card.dart';
import 'package:shop_demo/features/home/presentation/widgets/search_bar_pill.dart';
import 'package:shop_demo/l10n/app_localizations.dart';
import 'package:shop_demo/shared/widgets/error_display.dart';
import 'package:shop_demo/shared/widgets/language_switcher.dart';
import 'package:shop_demo/shared/widgets/skeleton_loader.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final categories = ref.watch(categoriesProvider);
    final listings = ref.watch(featuredListingsProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(categoriesProvider);
          ref.invalidate(featuredListingsProvider);
          return Future.wait([
            ref.read(categoriesProvider.future),
            ref.read(featuredListingsProvider.future),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            // ── Top nav ──────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.base, AppSpacing.md, AppSpacing.base, AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.appName,
                      style: AppTypography.titleMd.copyWith(color: AppColors.primary),
                    ),
                    const Spacer(),
                    const LanguageSwitcher(),
                    const SizedBox(width: AppSpacing.base),
                    const CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.surfaceStrong,
                      child: Icon(Icons.person, size: 18, color: AppColors.ink),
                    ),
                  ],
                ),
              ),
            ),

            // ── Search bar pill ──────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.base,
                  vertical: AppSpacing.sm,
                ),
                child: SearchBarPill(
                  onTap: () => context.push('/search'),
                ),
              ),
            ),

            // ── Category strip ───────────────────────────
            SliverToBoxAdapter(
              child: categories.when(
                data: (cats) => CategoryStrip(categories: cats),
                loading: () => const SizedBox(
                  height: 72,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => SizedBox(
                  height: 72,
                  child: Center(child: Text(l10n.error)),
                ),
              ),
            ),

            // ── Divider ─────────────────────────────────
            const SliverToBoxAdapter(
              child: Divider(color: AppColors.hairlineSoft, height: 1),
            ),

            // ── Section title ───────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.base, AppSpacing.lg, AppSpacing.base, AppSpacing.base,
                ),
                child: Text(
                  l10n.homeTitle,
                  style: AppTypography.displayXl.copyWith(color: AppColors.ink),
                ),
              ),
            ),

            // ── Responsive listing grid (Sliver* — no shrinkWrap) ──
            // SliverLayoutBuilder gives us the cross-axis extent so we can
            // switch between SliverList (mobile) and SliverGrid (tablet+).
            listings.when(
              data: (items) => SliverLayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = switch (constraints.crossAxisExtent) {
                    < 744 => 1,
                    < 1128 => 2,
                    < 1440 => 3,
                    _ => 4,
                  };

                  if (crossAxisCount == 1) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(
                            left: AppSpacing.base,
                            right: AppSpacing.base,
                            bottom: AppSpacing.lg,
                          ),
                          child: ListingCardWidget(
                            listing: items[index],
                            onTap: () => context.push('/listing/${items[index].id}'),
                          ),
                        ),
                        childCount: items.length,
                      ),
                    );
                  }

                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: AppSpacing.base,
                      mainAxisSpacing: AppSpacing.lg,
                      childAspectRatio: 0.75,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => ListingCardWidget(
                        listing: items[index],
                        onTap: () => context.push('/listing/${items[index].id}'),
                      ),
                      childCount: items.length,
                    ),
                  );
                },
              ),
              loading: () => const SliverToBoxAdapter(
                child: ListingGridSkeleton(),
              ),
              error: (e, _) => SliverToBoxAdapter(
                child: ErrorDisplay(
                  message: l10n.error,
                  onRetry: () => ref.invalidate(featuredListingsProvider),
                ),
              ),
            ),

            // ── Bottom spacing ───────────────────────────
            const SliverToBoxAdapter(
              child: SizedBox(height: AppSpacing.section),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Create SkeletonLoader (shared utility)**

```dart
// frontend/lib/shared/widgets/skeleton_loader.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_radius.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.surfaceSoft,
      highlightColor: AppColors.canvas,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.surfaceSoft,
          borderRadius: borderRadius ??
              BorderRadius.circular(AppRadius.sm),
        ),
      ),
    );
  }
}

class ListingGridSkeleton extends StatelessWidget {
  const ListingGridSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Column(
        children: List.generate(
          3,
          (_) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonLoader(
                  width: double.infinity,
                  height: 300,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                const SizedBox(height: AppSpacing.sm),
                const SkeletonLoader(width: 200, height: 16),
                const SizedBox(height: 4),
                const SkeletonLoader(width: 150, height: 14),
                const SizedBox(height: 4),
                const SkeletonLoader(width: 100, height: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2b: Create ErrorDisplay (shared utility)**

```dart
// frontend/lib/shared/widgets/error_display.dart
import 'package:flutter/material.dart';
import 'package:shop_demo/app/theme/app_colors.dart';
import 'package:shop_demo/app/theme/app_spacing.dart';
import 'package:shop_demo/app/theme/app_typography.dart';
import 'package:shop_demo/l10n/app_localizations.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorDisplay({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.muted),
            const SizedBox(height: AppSpacing.base),
            Text(message, style: AppTypography.bodySm.copyWith(color: AppColors.muted), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.base),
              TextButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(l10n.retry),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Wire HomePage into the router**

Edit `frontend/lib/app/router/app_router.dart` — replace the home placeholder:

```dart
// In app_router.dart, replace:
//   builder: (context, state) => const _PlaceholderPage('Home'),
// with:
import 'package:shop_demo/features/home/presentation/pages/home_page.dart';

// ...in the route definition:
GoRoute(
  path: '/',
  name: 'home',
  builder: (context, state) => const HomePage(),
),
```

- [ ] **Step 4: Verify app runs with home page**

```bash
flutter run -d chrome --web-port=3000
```

Expected: Full home page with pill search bar, horizontal categories, and listing cards with photos.

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/features/home/presentation/pages/home_page.dart
git add frontend/lib/shared/widgets/skeleton_loader.dart
git add frontend/lib/app/router/app_router.dart
git commit -m "feat: add home page with search bar, categories, and listing grid"
```

---

### Task 2.9: Animation & Motion Design

Demo apps live and die by motion quality. This task adds the four key animations that give the app an Airbnb feel. All use built-in Flutter animation primitives — zero third-party dependencies.

**Files:**
- Modify: `frontend/lib/features/home/presentation/widgets/listing_card.dart` (Hero + heart spring already added in Task 2.7)
- Create: `frontend/lib/shared/widgets/staggered_list.dart`

- [ ] **Step 1: Heart spring animation (already in ListingCardWidget)**

The heart icon in `ListingCardWidget` uses a `ScaleTransition` driven by an `AnimationController`. On tap, `forward()` triggers a spring-like scale bounce (0.6 → 1.0). This is already implemented in Task 2.7.

- [ ] **Step 2: Hero transition (listing card → detail page)**

The `Hero` widget wraps the `PhotoCarousel` in `ListingCardWidget` with tag `listing_photo_<id>`. The detail page's `PhotoBanner` (Task 3.2) uses the same tag. Flutter handles the cross-route morph automatically.

```dart
// In ListingCardWidget (Task 2.7):
Hero(
  tag: 'listing_photo_${l.id}',
  child: PhotoCarousel(...),
)

// In PhotoBanner (Task 3.2):
Hero(
  tag: 'listing_photo_${listing.id}',
  child: PhotoCarousel(imageUrls: listing.imageUrls, aspectRatio: 16/9),
)
```

- [ ] **Step 3: Staggered card entrance animation**

Create a `StaggeredList` wrapper that animates children with a staggered delay as they enter the viewport. Uses `SlideTransition` + `FadeTransition` with per-item `Interval` delays (50ms per item).

```dart
// frontend/lib/shared/widgets/staggered_list.dart
import 'package:flutter/material.dart';

/// Wraps each child in a staggered slide-up + fade entrance.
/// Items animate in one-by-one with [delayPerItem] between each.
class StaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration delayPerItem;
  final Duration animationDuration;
  final Curve curve;

  const StaggeredList({
    super.key,
    required this.children,
    this.delayPerItem = const Duration(milliseconds: 60),
    this.animationDuration = const Duration(milliseconds: 350),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<StaggeredList> createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration +
          widget.delayPerItem * (widget.children.length - 1),
    );
    // Start animation after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.forward());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.children.length, (i) {
        final start = (i * widget.delayPerItem.inMilliseconds) /
            _controller.duration!.inMilliseconds;
        final end = start + 0.5;
        if (end > 1.0) {
          // Late items: compress into remaining time
          return FadeTransition(
            opacity: _controller,
            child: widget.children[i],
          );
        }
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final anim = Interval(start, end, curve: widget.curve)
                .transform(_controller.value);
            return Opacity(
              opacity: anim,
              child: Transform.translate(
                offset: Offset(0, 20 * (1 - anim)),
                child: child,
              ),
            );
          },
          child: widget.children[i],
        );
      }),
    );
  }
}
```

Usage in `HomePage` — wrap the listing items in `StaggeredList` when using `SliverList` (mobile). For `SliverGrid`, apply the staggered entrance via individual item widgets that read a shared animation.

- [ ] **Step 4: Category strip indicator animation**

The category strip's selected underline indicator uses `AnimatedContainer` for smooth sliding:

```dart
// Inside _CategoryItem (category_strip.dart), replace the indicator:
AnimatedContainer(
  duration: const Duration(milliseconds: 250),
  curve: Curves.easeOutCubic,
  height: 2,
  width: isSelected ? 24 : 0,
  color: isSelected ? AppColors.ink : Colors.transparent,
),
```

- [ ] **Step 5: Detail page parallax scroll (for Task 3.2)**

The `PhotoBanner` on the detail page uses a `ScrollController` to create a parallax effect — the image scrolls at half the rate of the content:

```dart
// In ListingDetailPage:
final _scrollController = ScrollController();
double _photoOffset = 0;

@override
void initState() {
  super.initState();
  _scrollController.addListener(() {
    setState(() => _photoOffset = _scrollController.offset * 0.5);
  });
}

// PhotoBanner wrapped in a Transform:
Transform.translate(
  offset: Offset(0, _photoOffset),
  child: const PhotoBanner(...),
)
```

- [ ] **Step 6: Commit**

```bash
git add frontend/lib/shared/widgets/staggered_list.dart
git add frontend/lib/features/home/presentation/widgets/listing_card.dart
git add frontend/lib/features/home/presentation/widgets/category_strip.dart
git commit -m "feat: add animation system — Hero, heart spring, staggered entrance, parallax"
```

---

## Chunk 3: Listing Detail + Search Features

### Task 3.1: Listing Detail — Mock Data & Domain

**Files:**
- Create: `frontend/lib/features/listing/domain/listing_detail.dart`
- Create: `frontend/lib/features/listing/domain/review.dart`
- Create: `frontend/lib/features/listing/domain/amenity.dart`
- Create: `frontend/lib/features/listing/data/listing_mock_data.dart`
- Create: `frontend/lib/features/listing/data/listing_repository.dart`
- Create: `frontend/lib/features/listing/presentation/providers/listing_provider.dart`

- [ ] **Step 1: Create domain entities** (same as before, with Equatable props containing all fields)

```dart
// frontend/lib/features/listing/domain/listing_detail.dart
import 'package:equatable/equatable.dart';
import 'amenity.dart';
import 'review.dart';

class ListingDetail extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<String> imageUrls;
  final String location;
  final double pricePerNight;
  final double rating;
  final int reviewCount;
  final bool isGuestFavorite;
  final int maxGuests;
  final int bedrooms;
  final int beds;
  final int bathrooms;
  final List<Amenity> amenities;
  final List<Review> reviews;
  final HostInfo host;

  const ListingDetail({
    required this.id, required this.title, required this.description,
    required this.imageUrls, required this.location,
    required this.pricePerNight, required this.rating,
    this.reviewCount = 0, this.isGuestFavorite = false,
    this.maxGuests = 1, this.bedrooms = 1, this.beds = 1, this.bathrooms = 1,
    this.amenities = const [], this.reviews = const [],
    required this.host,
  });

  @override
  List<Object?> get props => [id, title, pricePerNight, rating, reviewCount, isGuestFavorite];
}

class HostInfo extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final bool isSuperhost;
  final int hostingYears;
  final double responseRate;
  final String? bio;

  const HostInfo({
    required this.id, required this.name, required this.avatarUrl,
    this.isSuperhost = false, this.hostingYears = 0, this.responseRate = 0, this.bio,
  });

  @override
  List<Object?> get props => [id, name, isSuperhost];
}
```

Review and Amenity entities remain the same as before (see original definitions above), with Equatable props expanded to include all fields.

- [ ] **Step 2: Create mock data**

```dart
// frontend/lib/features/listing/data/listing_mock_data.dart
import 'package:shop_demo/features/listing/domain/listing_detail.dart';
import 'package:shop_demo/features/listing/domain/review.dart';
import 'package:shop_demo/features/listing/domain/amenity.dart';

/// Mock listing detail data. Unsplash image URLs require network connectivity.
abstract final class ListingMockData {
  static const amenities = [
    Amenity(id: 1, name: 'Wifi', iconKey: 'wifi'),
    Amenity(id: 2, name: 'Kitchen', iconKey: 'kitchen'),
    Amenity(id: 3, name: 'Free parking', iconKey: 'parking'),
    Amenity(id: 4, name: 'Pool', iconKey: 'pool'),
    Amenity(id: 5, name: 'Air conditioning', iconKey: 'ac'),
    Amenity(id: 6, name: 'Washer', iconKey: 'washer'),
    Amenity(id: 7, name: 'TV', iconKey: 'tv'),
    Amenity(id: 8, name: 'Gym', iconKey: 'gym'),
  ];

  static const review1 = Review(id: 'r1', userName: 'Sarah', userAvatarUrl: 'https://i.pravatar.cc/150?u=sarah', rating: 5, comment: 'Absolutely stunning. The treehouse was even better than the photos.', date: DateTime(2025, 10, 15));
  static const review2 = Review(id: 'r2', userName: 'Mike', userAvatarUrl: 'https://i.pravatar.cc/150?u=mike', rating: 4, comment: 'Great location and very clean. Would stay again.', date: DateTime(2025, 9, 3));
  static const review3 = Review(id: 'r3', userName: 'Emily', userAvatarUrl: 'https://i.pravatar.cc/150?u=emily', rating: 5, comment: 'The host was incredibly welcoming. Perfect getaway.', date: DateTime(2025, 11, 1));
  static const review4 = Review(id: 'r4', userName: 'James', userAvatarUrl: 'https://i.pravatar.cc/150?u=james', rating: 4, comment: 'Beautiful views, comfortable bed.', date: DateTime(2025, 8, 20));

  static final listings = {
    '1': ListingDetail(
      id: '1', title: 'Secluded Treehouse Getaway',
      description: 'Escape to this magical treehouse nestled in the Blue Ridge Mountains. Wake up to birdsong, enjoy coffee on the wrap-around deck, and stargaze from the outdoor hot tub. Perfect for a romantic retreat or solo recharge.',
      imageUrls: ['https://images.unsplash.com/photo-1564013799919-ab600027ffc6?w=1200', 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?w=1200', 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=1200', 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=1200'],
      location: 'Asheville, North Carolina', pricePerNight: 185, rating: 4.92,
      reviewCount: 128, isGuestFavorite: true, maxGuests: 2, bedrooms: 1, beds: 1, bathrooms: 1,
      amenities: [amenities[0], amenities[4], amenities[2], amenities[3], amenities[6]],
      reviews: [review1, review2, review3],
      host: const HostInfo(id: 'h1', name: 'Rebecca', avatarUrl: 'https://i.pravatar.cc/150?u=rebecca', isSuperhost: true, hostingYears: 5, responseRate: 98, bio: 'Outdoor enthusiast and former architect. I love sharing this special place with guests.'),
    ),
    '2': ListingDetail(
      id: '2', title: 'Modern Loft in Downtown',
      description: 'Sleek industrial loft in the heart of Portland\'s Pearl District. Exposed brick, 14-foot ceilings, and floor-to-ceiling windows. Walk to the best restaurants, breweries, and parks the city has to offer.',
      imageUrls: ['https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=1200', 'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?w=1200', 'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=1200'],
      location: 'Portland, Oregon', pricePerNight: 120, rating: 4.78, reviewCount: 95,
      maxGuests: 4, bedrooms: 2, beds: 2, bathrooms: 1,
      amenities: [amenities[0], amenities[1], amenities[4], amenities[6]],
      reviews: [review4, review2],
      host: const HostInfo(id: 'h2', name: 'David', avatarUrl: 'https://i.pravatar.cc/150?u=david', isSuperhost: false, hostingYears: 2, responseRate: 92),
    ),
    '3': ListingDetail(
      id: '3', title: 'Oceanfront Villa with Pool',
      description: 'Stunning modernist villa perched on the Malibu cliffs. Infinity pool, private beach access, and panoramic ocean views from every room. This is California living at its finest.',
      imageUrls: ['https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=1200', 'https://images.unsplash.com/photo-1600585154526-990dced4db0d?w=1200', 'https://images.unsplash.com/photo-1600573472592-401b489a3cdc?w=1200', 'https://images.unsplash.com/photo-1600566753086-00f18fb6b3ea?w=1200', 'https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?w=1200'],
      location: 'Malibu, California', pricePerNight: 450, rating: 4.96, reviewCount: 210,
      isGuestFavorite: true, maxGuests: 6, bedrooms: 3, beds: 4, bathrooms: 2,
      amenities: [amenities[0], amenities[1], amenities[2], amenities[3], amenities[4], amenities[5], amenities[6], amenities[7]],
      reviews: [review1, review3, review2, review4],
      host: const HostInfo(id: 'h3', name: 'Lauren', avatarUrl: 'https://i.pravatar.cc/150?u=lauren', isSuperhost: true, hostingYears: 8, responseRate: 99, bio: 'Interior designer with a passion for creating unforgettable spaces.'),
    ),
  };
}
```

- [ ] **Step 3: Create repository**

```dart
// frontend/lib/features/listing/data/listing_repository.dart
import 'package:shop_demo/features/listing/data/listing_mock_data.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';

/// Single concrete repository for listing detail.
/// Replaced with API-backed implementation in Task 5.1.
class ListingRepository {
  Future<ListingDetail?> getById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return ListingMockData.listings[id];
  }
}
```

- [ ] **Step 4: Create providers**

```dart
// frontend/lib/features/listing/presentation/providers/listing_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_demo/features/listing/data/listing_repository.dart';
import 'package:shop_demo/features/listing/domain/listing_detail.dart';

final listingRepositoryProvider = Provider<ListingRepository>((ref) {
  return ListingRepository();
});

final listingDetailProvider = FutureProvider.autoDispose
    .family<ListingDetail?, String>((ref, id) async {
  final repo = ref.watch(listingRepositoryProvider);
  return repo.getById(id);
});
```

- [ ] **Step 5: Commit**

```bash
git add frontend/lib/features/listing/
git commit -m "feat: add listing detail domain, mock data, repository, and providers"
```

---

### Task 3.2: Listing Detail — Widgets

**Files:**
- Create: `frontend/lib/features/listing/presentation/widgets/photo_banner.dart`
- Create: `frontend/lib/features/listing/presentation/widgets/rating_display_card.dart`
- Create: `frontend/lib/features/listing/presentation/widgets/amenity_list.dart`
- Create: `frontend/lib/features/listing/presentation/widgets/host_card.dart`
- Create: `frontend/lib/features/listing/presentation/widgets/reviews_section.dart`
- Create: `frontend/lib/features/listing/presentation/widgets/reservation_card.dart`

- [ ] **Step 1: Implement PhotoBanner** — full-width image gallery with Hero tag for transition

```dart
// frontend/lib/features/listing/presentation/widgets/photo_banner.dart
// Uses Hero(tag: 'listing_photo_<id>') to match the listing card Hero in Task 2.7.
// Wraps PhotoCarousel with aspectRatio: 16/9. On desktop, shows a 2-column
// grid of images instead of a carousel.
```

- [ ] **Step 2: Implement RatingDisplayCard** — the signature 64px rating number

```dart
// frontend/lib/features/listing/presentation/widgets/rating_display_card.dart
// Displays '4.92' in AppTypography.ratingDisplay (64px w700) with a star icon
// and review count below. Airbnb's signature detail-page element.
```

- [ ] **Step 3: Implement AmenityList** — icon + label rows

```dart
// frontend/lib/features/listing/presentation/widgets/amenity_list.dart
// Maps amenity.iconKey → Material IconData via a switch, renders in a
// Column of Row(Icon(28px), SizedBox(16), Text(name)) with Divider between.
```

- [ ] **Step 4: Implement HostCard** — avatar, name, superhost badge, response rate
- [ ] **Step 5: Implement ReviewsSection** — 2-column grid of review excerpts with rating
- [ ] **Step 6: Implement ReservationCard** — price per night, date picker trigger, guest counter trigger, Reserve button (fixed bottom on mobile, sticky sidebar on desktop)

- [ ] **Step 7: Commit**

```bash
git add frontend/lib/features/listing/presentation/widgets/
git commit -m "feat: add listing detail widgets (photo banner, rating, amenities, host, reviews, reservation)"
```

---

### Task 3.4: Search Feature — Filter & UI

**Files:**
- Create: `frontend/lib/features/search/domain/search_filter.dart`
- Create: `frontend/lib/features/search/data/search_repository.dart`
- Create: `frontend/lib/features/search/presentation/providers/search_provider.dart`
- Create: `frontend/lib/features/search/presentation/widgets/search_overlay.dart`
- Create: `frontend/lib/features/search/presentation/widgets/date_range_picker.dart`
- Create: `frontend/lib/features/search/presentation/widgets/guest_counter.dart`
- Create: `frontend/lib/features/search/presentation/widgets/filter_chip_bar.dart`
- Create: `frontend/lib/features/search/presentation/pages/search_page.dart`
- Create: `frontend/lib/features/search/presentation/pages/search_results_page.dart`

- [ ] **Step 1: Create SearchFilter entity** — query, category, dateRange, guests, priceRange, sortBy. Use a simple Dart class (no freezed needed at this scale).

```dart
// frontend/lib/features/search/domain/search_filter.dart
class SearchFilter {
  final String? query;
  final String? category;
  final DateTimeRange? dateRange;
  final int adults;
  final int children;
  final int infants;
  final double? minPrice;
  final double? maxPrice;
  final SortBy sortBy;

  const SearchFilter({
    this.query, this.category, this.dateRange,
    this.adults = 1, this.children = 0, this.infants = 0,
    this.minPrice, this.maxPrice,
    this.sortBy = SortBy.relevance,
  });

  SearchFilter copyWith({...}) => SearchFilter(...);
  int get totalGuests => adults + children;
}

enum SortBy { relevance, priceLow, priceHigh, rating, newest }
```

- [ ] **Step 2: Create SearchRepository** — filters the combined mock data from home + listing mock data sources by query, category (prefix match), price range, and guest count.

```dart
// frontend/lib/features/search/data/search_repository.dart
class SearchRepository {
  Future<List<ListingCard>> search(SearchFilter filter) async {
    await Future.delayed(const Duration(milliseconds: 400));
    var results = [...HomeMockData.listings];
    if (filter.query != null && filter.query!.isNotEmpty) {
      final q = filter.query!.toLowerCase();
      results = results.where((l) =>
        l.title.toLowerCase().contains(q) ||
        l.location.toLowerCase().contains(q)).toList();
    }
    if (filter.minPrice != null) results = results.where((l) => l.pricePerNight >= filter.minPrice!).toList();
    if (filter.maxPrice != null) results = results.where((l) => l.pricePerNight <= filter.maxPrice!).toList();
    // Sort by filter.sortBy...
    return results;
  }
}
```

- [ ] **Step 3: Create SearchProvider** — `StateNotifier<SearchFilter>` with methods to update individual filter fields
- [ ] **Step 4: Implement DateRangePicker** — custom Airbnb-style calendar with range selection, horizontal swipe between months
- [ ] **Step 5: Implement GuestCounter** — increment/decrement stepper for adults, children, infants
- [ ] **Step 6: Implement FilterChipBar** — horizontal scrollable filter chips for quick category switches
- [ ] **Step 7: Implement SearchOverlay** — full-screen search on mobile (<744px), sidebar panel on desktop
- [ ] **Step 8: Implement SearchPage & SearchResultsPage** — search form + results grid reusing ListingCardWidget
- [ ] **Step 9: Wire into router** — `/search` for search form, `/search/results` for results
- [ ] **Step 10: Commit**

```bash
git add frontend/lib/features/search/
git commit -m "feat: add search feature with filters, date picker, guest counter"
```

---

## Chunk 4: Backend API (Dart Frog + PostgreSQL)

### Task 4.1: Docker Compose + PostgreSQL

**Files:**
- Create: `docker-compose.yml`

- [ ] **Step 1: Create docker-compose.yml**

```yaml
# docker-compose.yml
version: '3.8'
services:
  postgres:
    image: postgres:16-alpine
    environment:
      POSTGRES_DB: shop_demo
      POSTGRES_USER: shop_user
      POSTGRES_PASSWORD: shop_password
    ports:
      - '5432:5432'
    volumes:
      - pgdata:/var/lib/postgresql/data
      - ./backend/lib/database/schema.sql:/docker-entrypoint-initdb.d/01-schema.sql

volumes:
  pgdata:
```

- [ ] **Step 2: Create schema.sql** (from the database design above)
- [ ] **Step 3: Start PostgreSQL**

```bash
docker compose up -d postgres
```

- [ ] **Step 4: Commit**

```bash
git add docker-compose.yml backend/lib/database/schema.sql
git commit -m "feat: add Docker Compose with PostgreSQL"
```

---

### Task 4.2: Dart Frog Project Setup

**Files:**
- Create: `backend/pubspec.yaml`
- Create: `backend/dart_frog.yaml`

- [ ] **Step 1: Initialize Dart Frog project**

```bash
cd /Users/zhouquan/Desktop/Shop_Demo
dart_frog create backend
```

- [ ] **Step 2: Add dependencies** (drift, postgresql, dart_jsonwebtoken, etc.)
- [ ] **Step 3: Create health check route**
- [ ] **Step 4: Verify backend starts**

```bash
cd backend
dart_frog dev
```

Expected: Server running on http://localhost:8080

- [ ] **Step 5: Commit**

```bash
git add backend/
git commit -m "feat: initialize Dart Frog backend project"
```

---

### Task 4.3: Database Layer (Drift ORM)

**Files:**
- Create: `backend/lib/database/tables/` (all table definitions)
- Create: `backend/lib/database/database_context.dart`
- Create: `backend/lib/database/daos/` (user_dao, listing_dao, booking_dao, review_dao)

- [ ] **Step 1: Define Drift tables** (users, listings, categories, images, amenities, bookings, reviews, favorites)
- [ ] **Step 2: Create DatabaseContext**
- [ ] **Step 3: Create DAOs with common queries**
- [ ] **Step 4: Write unit tests for DAOs**
- [ ] **Step 5: Commit**

```bash
git add backend/lib/database/
git commit -m "feat: add Drift ORM tables, database context, and DAOs"
```

---

### Task 4.4: Auth Module (JWT)

**Files:**
- Create: `backend/lib/services/auth_service.dart`
- Create: `backend/lib/middleware/auth_middleware.dart`
- Create: `backend/routes/api/auth/login.dart`
- Create: `backend/routes/api/auth/register.dart`
- Create: `backend/routes/api/auth/refresh.dart`

- [ ] **Step 1: Implement AuthService** (hashPassword, generateToken, verifyToken)
- [ ] **Step 2: Implement AuthMiddleware**
- [ ] **Step 3: Create login/register/refresh routes**
- [ ] **Step 4: Write integration tests**
- [ ] **Step 5: Commit**

```bash
git add backend/lib/services/auth_service.dart backend/lib/middleware/ backend/routes/api/auth/
git commit -m "feat: add JWT auth with login, register, refresh endpoints"
```

---

### Task 4.5: Listings + Search API

**Files:**
- Create: `backend/lib/services/listing_service.dart`
- Create: `backend/lib/services/search_service.dart`
- Create: `backend/routes/api/listings/index.dart`
- Create: `backend/routes/api/listings/[id].dart`
- Create: `backend/routes/api/listings/search.dart`
- Create: `backend/routes/api/categories/index.dart`

- [ ] **Step 1: Implement ListingService** (getById, getFeatured, create)
- [ ] **Step 2: Implement SearchService** (full-text search with filters, pagination)
- [ ] **Step 3: Create API routes**
- [ ] **Step 4: Write integration tests**
- [ ] **Step 5: Commit**

```bash
git add backend/lib/services/listing_service.dart backend/lib/services/search_service.dart backend/routes/api/listings/ backend/routes/api/categories/
git commit -m "feat: add listings CRUD and search API endpoints"
```

---

### Task 4.6: Bookings + Reviews API

**Files:**
- Create: `backend/lib/services/booking_service.dart`
- Create: `backend/routes/api/bookings/index.dart`
- Create: `backend/routes/api/bookings/[id].dart`
- Create: `backend/routes/api/reviews/[listingId].dart`
- Create: `backend/routes/api/user/profile.dart`
- Create: `backend/routes/api/user/favorites.dart`

- [ ] **Step 1: Implement BookingService** (create, getByUser, cancel)
- [ ] **Step 2: Create booking routes**
- [ ] **Step 3: Create review routes**
- [ ] **Step 4: Create user profile + favorites routes**
- [ ] **Step 5: Write integration tests**
- [ ] **Step 6: Commit**

```bash
git add backend/
git commit -m "feat: add bookings, reviews, user profile, and favorites API"
```

---

## Chunk 5: Frontend-Backend Integration + Auth + Booking

### Task 5.1: Swap Mock → API Repositories

**Files:**
- Modify: `frontend/lib/features/home/presentation/providers/home_provider.dart`
- Modify: `frontend/lib/features/listing/presentation/providers/listing_provider.dart`
- Modify: `frontend/lib/features/search/presentation/providers/search_provider.dart`
- Create: `frontend/lib/features/home/data/models/category_model.dart`
- Create: `frontend/lib/features/home/data/models/listing_card_model.dart`
- Create: `frontend/lib/features/listing/data/models/listing_detail_model.dart`

- [ ] **Step 1: Create JSON models** (with json_serializable/freezed)
- [ ] **Step 2: Create API-backed repository implementations**
- [ ] **Step 3: Swap provider implementations** (change from MockRepo to ApiRepo)
- [ ] **Step 4: Test full flow: home → listing detail → back**
- [ ] **Step 5: Commit**

```bash
git add frontend/lib/features/
git commit -m "feat: swap mock repositories to API-backed implementations"
```

---

### Task 5.2: Auth Feature (Frontend)

**Files:**
- Create: `frontend/lib/features/auth/data/models/user_model.dart`
- Create: `frontend/lib/features/auth/data/models/auth_response.dart`
- Create: `frontend/lib/features/auth/data/repositories/auth_repository_impl.dart`
- Create: `frontend/lib/features/auth/domain/entities/user.dart`
- Create: `frontend/lib/features/auth/domain/repositories/auth_repository.dart`
- Create: `frontend/lib/features/auth/presentation/providers/auth_provider.dart`
- Create: `frontend/lib/features/auth/presentation/pages/login_page.dart`
- Create: `frontend/lib/features/auth/presentation/pages/register_page.dart`
- Modify: `frontend/lib/core/network/api_client.dart` (wire auth interceptor)

- [ ] **Step 1: Create auth domain + data layer**
- [ ] **Step 2: Implement AuthProvider** (login, logout, register, currentUser)
- [ ] **Step 3: Implement LoginPage** (email + password form, styled per Airbnb)
- [ ] **Step 4: Implement RegisterPage**
- [ ] **Step 5: Wire auth token into ApiClient interceptor**
- [ ] **Step 6: Wire login/register routes into GoRouter**
- [ ] **Step 7: Commit**

```bash
git add frontend/lib/features/auth/
git commit -m "feat: add auth feature with login, register, and token management"
```

---

### Task 5.3: Booking Feature (Frontend)

**Files:**
- Create: `frontend/lib/features/booking/data/models/booking_model.dart`
- Create: `frontend/lib/features/booking/data/repositories/booking_repository_impl.dart`
- Create: `frontend/lib/features/booking/domain/entities/booking.dart`
- Create: `frontend/lib/features/booking/domain/repositories/booking_repository.dart`
- Create: `frontend/lib/features/booking/presentation/providers/booking_provider.dart`
- Create: `frontend/lib/features/booking/presentation/pages/booking_page.dart`
- Create: `frontend/lib/features/booking/presentation/pages/booking_confirmation_page.dart`
- Create: `frontend/lib/features/booking/presentation/widgets/fee_breakdown.dart`

- [ ] **Step 1: Create booking domain + data layer**
- [ ] **Step 2: Implement BookingProvider**
- [ ] **Step 3: Implement BookingPage** (date picker, guest counter, fee breakdown, Reserve button)
- [ ] **Step 4: Implement BookingConfirmationPage**
- [ ] **Step 5: Wire into router**
- [ ] **Step 6: Commit**

```bash
git add frontend/lib/features/booking/
git commit -m "feat: add booking flow with date picker and fee breakdown"
```

---

### Task 5.4: Profile Feature (Frontend)

**Files:**
- Create: `frontend/lib/features/profile/data/repositories/profile_repository_impl.dart`
- Create: `frontend/lib/features/profile/domain/repositories/profile_repository.dart`
- Create: `frontend/lib/features/profile/presentation/providers/profile_provider.dart`
- Create: `frontend/lib/features/profile/presentation/pages/profile_page.dart`
- Create: `frontend/lib/features/profile/presentation/pages/my_bookings_page.dart`
- Create: `frontend/lib/features/profile/presentation/pages/favorites_page.dart`

- [ ] **Step 1: Create profile domain + data layer**
- [ ] **Step 2: Implement ProfileProvider**
- [ ] **Step 3: Implement ProfilePage** (avatar, name, menu items)
- [ ] **Step 4: Implement MyBookingsPage** (list of bookings with status)
- [ ] **Step 5: Implement FavoritesPage** (saved listings grid)
- [ ] **Step 6: Wire into router**
- [ ] **Step 7: Commit**

```bash
git add frontend/lib/features/profile/
git commit -m "feat: add profile, my bookings, and favorites pages"
```

---

## Chunk 6: Responsive Polish + Final Integration

### Task 6.1: Responsive Layout Refinements

- [ ] **Step 1: Implement ResponsiveBuilder** shared utility
- [ ] **Step 2: Refine ListingDetailPage** — 2-column desktop / stacked mobile
- [ ] **Step 3: Refine SearchOverlay** — full-screen mobile / sidebar desktop
- [ ] **Step 4: Refine ReservationCard** — sticky sidebar desktop / sticky bottom bar mobile
- [ ] **Step 5: Test on all 3 breakpoints** (mobile 375px, tablet 768px, desktop 1280px)
- [ ] **Step 6: Commit**

```bash
git add frontend/lib/
git commit -m "feat: responsive layout refinements for all breakpoints"
```

---

### Task 6.2: Navigation Shell (Bottom Bar + Top Nav)

- [ ] **Step 1: Implement bottom navigation bar** (Home, Search, Favorites, Profile)
- [ ] **Step 2: Implement top navigation bar** (desktop: logo + search + nav links)
- [ ] **Step 3: Platform-aware shell** (bottom bar on mobile/tablet, top nav on desktop)
- [ ] **Step 4: Commit**

```bash
git add frontend/lib/
git commit -m "feat: add responsive navigation shell (bottom bar + top nav)"
```

---

### Task 6.3: Seed Data + Final Demo Flow

- [ ] **Step 1: Create backend seed script** (insert 10+ listings, 3 categories, 5 users)
- [ ] **Step 2: Verify complete user flow**
  - Home → Search → Listing Detail → Book → Confirmation → Profile → My Bookings
- [ ] **Step 3: Run Flutter analyzer** (`flutter analyze --no-fatal-infos`)
- [ ] **Step 4: Run all tests** (`flutter test`)
- [ ] **Step 5: Final commit**

```bash
git add .
git commit -m "feat: complete Flutter shop demo with Airbnb-inspired design"
```

---

## Execution Summary

| Chunk | Phase | Focus | Key Deliverables |
|-------|-------|-------|-----------------|
| 1 | Phase 1 | Scaffold + Design System + i18n | Flutter project, theme, router, core infra, EN/ZH bilingual |
| 2 | Phase 1 | Home Page | Pill search, categories, listing cards, animations (Hero, spring, staggered), mock data |
| 3 | Phase 2 | Listing + Search | Detail page (parallax), search/filter, date picker |
| 4 | Phase 3 | Backend API | Dart Frog, PostgreSQL, all REST endpoints |
| 5 | Phase 4 | Auth + Booking | Login/register, booking flow, profile |
| 6 | Phase 5 | Polish | Responsive layout, navigation shell, seed data |

**Estimated total:** ~30 tasks, ~150 steps, ~30-40 hours of focused development.

**Start with Chunk 1, Task 1.1.**

---

## Explicit Out-of-Scope

The following DESIGN.md components are intentionally not implemented in this demo:
- **Footer** (`footer-light`, `legal-band`, `footer-link`) — low value for demo
- **Top navigation** (`top-nav`, `product-tab-active/inactive`) — replaced by simpler bottom nav + logo
- **City link grid** — editorial content, not core commerce flow
- **Experience cards** (4:5 aspect ratio) — secondary product type
- **Map view** — requires Mapbox/Google Maps integration
- **Full payment processing** — uses mock payment only

## Review Notes (2026-04-29, updated)

Round 1 review (initial):
- ✅ Added i18n infrastructure as Task 1.11 (EN + Chinese ARB files, locale-aware formatters, language switcher)
- ✅ Fixed domain layer contamination (Amenity entity no longer imports Flutter)
- ✅ Removed redundant files from map
- ✅ Added `flutter_localizations` to pubspec, removed unused packages
- ✅ Documented parallelizable tasks for subagent-driven development
- ✅ Documented explicit out-of-scope items

Round 2 review (architecture + performance + animation):
- ✅ **P0:** Fixed Equatable props to include all fields (was `[id]` only — Riverpod wouldn't detect state changes)
- ✅ **P0:** Fixed `NumberFormat`/`DateFormat` to cache per locale (was re-creating on every call)
- ✅ **P0:** Fixed `uppercaseTag` fontSize 8→10 (was below accessibility minimum)
- ✅ **P0:** Removed `shrinkWrap: true` anti-pattern — replaced `ListingGrid` widget with `SliverList`/`SliverGrid` directly in `CustomScrollView`
- ✅ **P1:** Reduced Inter font weights from 8 to 3 (400/500/700, ~2MB savings)
- ✅ **P1:** Merged domain entities + data models (entities serve both roles — removed ~12 redundant files)
- ✅ **P1:** Removed abstract repository interfaces (single concrete class per feature — removed ~8 files)
- ✅ **P1:** Removed `l10n.dart` barrel export
- ✅ **P1:** Added animation system (Hero transition, heart spring, staggered entrance, category indicator animation, parallax scroll)
- ✅ **P1:** Wired `_AuthInterceptor` from Task 1.9 (token getter callback, no more placeholder)
- ✅ **P1:** Added `RefreshIndicator` pull-to-refresh on HomePage
- ✅ **P1:** Added `ErrorDisplay` widget with retry button, used in HomePage
- ✅ **P1:** Added mock data network dependency note
- ✅ **P2:** Expanded Chunk 3 Tasks 3.1-3.4 with full code detail (entities, mock data, repository, providers, widget specs)
- ⚠️ Chunks 4–6 remain at execute-time expansion level (backend + integration already have sufficient structural detail)
