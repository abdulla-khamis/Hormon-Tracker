# 06 - Tech Stack and Architecture (LOCKED: Flutter per owner 2026-09-05)

> Owner decision: Flutter 3.x. No further debate unless owner reopens.

## Recommended: Flutter 3.x (Dart) — Single Codebase iOS + Android
**Why:** Best for ar/en RTL + one unified chart + rich animation (Rive/Lottie) + light 3D (flutter_3d_controller / model_viewer) + fast to best-in-MENA MVP. Strong Health plugins.
- UI: Flutter + Material3 + custom `AppTheme` (light/dark, shared tokens).
- State: Riverpod (or Bloc — team vote) + Freezed models + Hive (offline cache) + Supabase (Postgres + Auth + Remote Config + Storage).
- Charts/3D: Custom `HormoneBalanceChart` (CustomPainter) + Rive mascot + optional Three.js-style 3D brain/body toggle (low-poly, performant, toggleable for low-end devices).
- i18n: `flutter_localizations` + `intl` + `gen-l10n`, `ar` RTL, `en` LTR. Hijri dates via `hijri` package (no hardcode).
- Health: `health` package (HealthKit on iOS + Health Connect on Android) + Apple HealthKit entitlements + Health Connect permissions. Background sync via WorkManager.
- Backend (optional V1): Supabase or Firebase: Auth (Apple/Google/phone, anonymous guest upgrade — see `13_AUTH_AND_GUEST_MODE.md`), Firestore/Postgres, Remote Config for weights/tips, Crashlytics, Analytics (privacy-safe).
- CI/CD: GitHub Actions + Codemagic/Fastlane, flavors dev/staging/prod, golden tests for RTL + chart.

## Alternative (if owner insists)
- React Native + Expo + Reanimated + Three.js: also viable, larger JS talent pool in Egypt, but RTL + 3D slightly more work. Native Swift+Kotlin: best perf but 2x cost — NOT recommended for MVP.

## Architecture: Clean + Feature-First
```
lib/
  core/ (theme, l10n, configLoader, estimationEngine, safetyGuards)
  features/ (home, checkin, hormoneDetail, library, insights, settings)
  data/ (configRepo, healthRepo, estimateRepo, tipsRepo)
  widgets/ (HormoneBalanceChart, TipCard, FeelingGrid — reused everywhere)
assets/config/v1/*.json + lang/en.json, ar.json
```
- Offline-first: bundled config → works without internet; sync when online.
- EstimationEngine pure Dart, 100% unit-tested with doctor-approved fixtures. No UI logic inside.
- SafetyGuards layer blocks tips on red-flags/contraindications before render.

## Environments & Quality Gates
- Dev/Staging/Prod flavors, feature flags, OTA config version check on launch.
- Tests: unit (engine math), widget (RTL + chart values), integration (check-in <60s), golden (ar vs en layout).
- Performance: 60fps bars animation, <150ms estimate recompute, 3D toggle off on <3GB RAM.
- Security: encrypted storage (flutter_secure_storage), no health data in logs, consent receipts.

## Decision Needed (blocking)
Native vs Flutter vs React Native? Backend: Supabase vs Firebase? Offline-first required? See Q1-Q3 in file 12.
