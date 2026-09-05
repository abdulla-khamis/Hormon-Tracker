# 10 - Roadmap: MVP to Best in MENA (ORDERED MILESTONES, NO CALENDAR — Locked 2026-09-05)

Owner locks: NO weeks/days anywhere. Work runs in dependency order; anything marked ‖ may be done in parallel the same day. Target: code-complete MVP within ~7 days of start. Execution: solo dev + opencode agent. Test device: iPhone (exact model TBD) — Android via emulator + Play internal track until a physical device is confirmed.

## How To Read This File
- Milestones M0→M4 run in order. Inside a milestone, do items top-to-bottom; ‖ = independent, batch freely.
- Each milestone has an EXIT GATE (acceptance criteria, not a date). Do not advance on a red gate.
- Section "7-Day Sprint Scope" is the ONLY commitment for the 7-day target. Everything else is V1 backlog, still ordered.

## 7-Day Sprint Scope (Ruthless Cut — MUST vs DEFER)

MUST ship (code-complete):
- Guest-first onboarding + disclaimer, home `HormoneBalanceChart` (bars), 3-step check-in (10 feelings / 12 habits / 25 MENA foods from file 14), hormone detail with rebalance tips, feel-state library, settings (lang live-switch, theme, Islamic-factors toggle, export, wipe), red-flag cards, AR/EN RTL + dark mode, engine unit tests, Supabase guest→account backup (estimates+inputs only), HealthKit sleep/steps/workouts read-only (iOS first), store listings draft.
DEFER to V1 (explicitly NOT in the 7-day build):
- 3D body/brain, Rive mascot animation (static mascot placeholder), HR/HRV/mindfulness/cycle sync, insights curves + correlations, doctor PDF, Ramadan auto-mode (manual fasting factor stays), phone OTP, barcode/voice/watch/widgets, community.

Honest caveat (outside our control): Apple review ≈ 24-72h+ and new personal Play accounts may require a closed test (up to ~14 days) before production. "7 days" = code-complete + submitted, not guaranteed live on both stores.

## M0 — Foundations ‖ batch freely
- [ ] Flutter repo (stable), flavors dev/staging/prod, `analyze` clean, conventional commits, CI green.
- [ ] Folders per file 06 + `AppTheme` tokens + `gen-l10n` en/ar + RTL smoke screen (zero hardcoded strings proof).
- [ ] Supabase project (free tier) + dev/staging envs, `AuthRepo` interface, anonymous + Apple + Google + email-link; RLS rule denying health-table inserts (`health_upload:false` test).
- [ ] Freeze `assets/config/v1/*.json` from files 02/05/14 (hormones incl. hunger/stress cluster, habits, foods, thresholds ±8 caps, billing off, providers list).
- [ ] Submit Apple Developer ($99) + Play Console ($25) enrollments; record review lead times here.
- [ ] Privacy + deletion-URL + methods&limits pages live (store requires URLs).
EXIT GATE: offline build runs on iPhone; AR mirrors EN; dev login works; enrollments submitted.

## M1 — Estimator Core (depends: M0)
- [ ] `EstimationEngine` pure Dart (baselines + deltas + decay + confidence + cycle flag + version stamp) — file 05.
- [ ] 60+ engine unit tests from config fixtures (short sleep, night coffee x3, walk+sun, fasting day, shisha, soda crash) — must be 100% green.
- [ ] Hive boxes (profile/inputs/estimates/likes) keyed by `guestId` + offline link queue.
- [ ] Onboarding (guest-first, health primer, disclaimer tap) — file 04.
- [ ] Home chart bars + Why-chips + confidence badge + Hijri date.
- [ ] Check-in 3 steps + animated bars morph on submit (<60s end-to-end).
EXIT GATE: fresh install → guest check-in → bars update; no literal strings/colors in UI (lint); engine tests pass.

## M2 — Retention Loop (depends: M1)
- [ ] Hormone detail sheet (do/eat/avoid + worship-factor tips + evidence badges + like/dislike).
- [ ] Feel-state library (10 states → labeled educational demo pattern + top-3 actions).
- [ ] Settings (language, theme, factors toggle, biometric opt-in, export JSON, erase device).
- [ ] Red-flag intercepts + >14d imbalance doctor nudge + EG hotlines config.
- [ ] AR QA: 320px width + 1.3x font + dark contrast + EN/AR goldens.
- [ ] Supabase backup/restore (estimates+inputs only) + logout keep/erase sheet.
EXIT GATE: tips traceable to sourceIds; library labeled non-diagnostic; restore verified via reinstall.

## M3 — Health + Performance (depends: M1; ‖ with M2)
- [ ] `health` package: sleep + steps + workouts read-only, primer screen, skip path, denied-state grace.
- [ ] Proxy mapping with low-confidence labels on thin data (file 05).
- [ ] Local nightly recompute + "Synced xh ago" subtitle.
- [ ] Perf: recompute <150ms, 60fps bars on mid Android emulator, cold start <1.5s offline; zero health values in logs (grep proof).
EXIT GATE: airplane-mode full loop green; health-denied path green.

## M4 — Launch EG (depends: M2 + M3)
- [ ] Test tracks (TestFlight + Play internal/closed) with ≥10 Cairo testers; collect AR UX notes.
- [ ] Listings ar/en (screenshots EN+AR, no lab-claim wording), EG-only availability, free, no IAP.
- [ ] Phased rollout 20%→100% with Remote Config kill-switches armed.
- [ ] Crashlytics + privacy-safe analytics (completion %, guest→login %, restore %; never health values).
- [ ] Re-run Gates M0-M3, Supabase <50% free tier, tag `v1.0.0-eg`, submit both stores.
EXIT GATE: submitted + monitoring live. Store approval time is external — track here.

## M5 — V1 Backlog (ordered, post-MVP)
1. HR/HRV/mindfulness/cycle sync (still on-device). 2. Insights curves + no-guilt streaks + correlation cards. 3. Doctor PDF export. 4. Ramadan auto-mode + exemptions. 5. Rive mascot + 3D toggle (RAM-gated, reduced-motion fallback). 6. OTA weights/tips rollout. 7. Dish DB + water/caffeine widgets + voice input. 8. Freemium ONLY if free-tier >80%.

## Testing Note (opencode execution)
Physical: iPhone 7 Plus (max iOS 15.8) — iOS minimum deployment target MUST be ≤ iOS 15 (e.g. iOS 14) or the device cannot install builds; verify in M0. Android: emulator only — matrix: mid-range API 31-34 + small-screen 320dp profile + 1.3x font pass.
Mobile testing uses `flutter test` + `integration_test` (+ Patrol if needed) on the 7 Plus + Android emulator — NOT Playwright (Playwright drives web browsers only; it applies solely if a landing/privacy web page is built). Every Done item ships with EN+AR device screenshots.

## Risks (no-doctor, solo, 7-day)
- Medical overclaim → §02.6 checklist per release; listing copy pre-cleared.
- Store external delays → enrollments M0, test tracks alongside M2/M3, never sequential.
- Scope creep (barcode/AI/lab) → M5 only, needs owner written OK.
- Single iPhone test device → emulator matrix for Android sizes; note device gaps in release notes.
