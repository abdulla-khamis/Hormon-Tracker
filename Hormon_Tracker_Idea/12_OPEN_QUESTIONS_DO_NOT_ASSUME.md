# 12 - Open Questions - DO NOT ASSUME (Blocking)

## DECIDED (2026-09-05, locked)
- D1 Tech: Flutter. D2 Hormones: Core 7 + Hunger/Stress (Insulin/Ghrelin/Leptin + Adrenaline + GABA). D3 Islamic: input factors like food, NO separate section. D4 Name: Horman Tracker (brand spelling kept). D5 Auth: Supabase, login optional guest-first, MVP+V1 = guest + Apple + Google + email-link ($0); phone OTP OFF (cost lock). D6 Habits/Foods: direction approved (coffee/shisha/sahar/gaming/social + koshary/dates/qahwa/karkadeh) → draft in file 14. D7 Health: on-device only (`health_upload:false`). D8 Reviewer: NO doctor — no-doctor mode (conservative ±8, evidence badges, disclaimers). D9 Monetization: free launch, 30-day free-all, stay free if costs allow (see file 15). D10 Launch: Egypt-only first (cost lock). D11 Capacity: solo dev, full-time, MVP 8 weeks, no Figma (Material3), Mac yes, store accounts none yet (creation W1 critical path). D12 (2026-09-06): NO calendar in roadmap — milestones M0-M4 in dependency order, ‖ = parallelizable same-day; 7-day code-complete target with MUST/DEFER cut; iPhone test device (model TBD); Supabase via opencode agent (no human prior experience assumed); mobile testing = flutter/integration_test, Playwright web-only. D13 (2026-09-06): physical test = iPhone 7 Plus (iOS 15.8 max → deployment target ≤15); Android = emulator only (API 31-34 + 320dp matrix). D14 (2026-09-06): brand lock — `Horman Tracker` Latin in BOTH languages (no Arabic transliteration); owner logo → `assets/images/app_logo.png` (in-app) + `app_icon_source.png` (launcher via flutter_launcher_icons). D15 (2026-09-06): launch opens LOGIN first (guest-first, no language screen); language switch lives ONLY in Settings; display name corrected to owner logo spelling `Hormon Tracker` everywhere visible; technical ids (`horman_tracker_app` package, `com.hormantracker` bundle) unchanged — invisible to users, rename would touch every import. D16 (2026-09-06): M1 DONE — pure EstimationEngine + 6 unit tests, JSON config loader, Hive guest store (memory fallback), unified HormoneBalanceChart, 3-step check-in, home with why-chips + confidence; 11 tests green, analyze clean. Test lesson: navigation needs the pushing screen's own context (never outer Builder context); route transitions need stepped pumps in widget tests. D11 Capacity: solo dev, full-time, MVP 8 weeks, no Figma (Material3), Mac yes, store accounts none yet (creation W1 critical path).

## Still Open (need owner reply in chat or here)

## Q1. Final Name & Branding
- Horman vs Hormon vs Hormone Tracker? Arabic name? (متتبع الهرمونات / هورمون تراكر / other?)
- Logo/mascot direction? Playful medical vs calm Islamic-geometric vs gym-energetic?

## Q2. Auth Backend (backend only — Flutter locked)
- Supabase Auth (recommended: anonymous guest + linkIdentity upgrade + RLS) vs Firebase Auth (easier phone OTP)? Phone OTP in MVP or V1 only? SMS provider + sender name? Do you have Mac for iOS build + team skills?

## Q7b. Guest Limits (new)
- Local history limit for guest (90 days?) vs unlimited cloud? Kids age gate 13 or 16? Data region?

## Q3. Platforms & Devices
- iOS + Android both MVP? Minimum versions? Tablet? Low-end Android support (affects 3D)?
- Apple Watch / Wear OS MVP or later? Which wearables do YOU use for testing?

## Q4. Hormone Scope MVP
- Confirm core 7 (dopamine/serotonin/oxytocin/endorphins/cortisol/melatonin/energy-sex) or add/remove? Include thyroid education? Include female cycle tracking MVP?
- Should energy-sex split into Testosterone + Estrogen separately with cycle phases?

## Q5. Inputs - Most Common Day
- What are YOUR top 12 daily actions/states to include? (e.g. coffee, shisha, night shift, exams, gaming, social media hours?) List them so config matches real Egypt/Saudi life, not generic US list.
- Top 25 MENA foods/drinks to include? (koshary, shawarma, dates, qahwa, karkadeh...? portions?)

## Q6. Islamic Features Depth
- Show Islamic tips always / toggleable / region-auto? Include prayer-time integration + Qibla? Or manual logging only (more private)?
- Ramadan auto-mode wanted? Hijri calendar display? Scholar review contact you trust for wording approval?

## Q7. Health Sync Privacy
- OK to request HealthKit/Health Connect (sleep/steps/workouts/HR/HRV)? On-device only MVP or cloud backup? Data residency (Egypt/Saudi/EU)? Age gate 13+ or 16+?

## Q8. Language & Theme
- Default language: follow phone or Arabic first? Arabic font preference (Tajawal/Cairo/IBM Plex Arabic)? Dark mode default?
- Medical Arabic glossary approval: who reviews? (doctor + linguist names?)

## Q9. Medical Safety Owner
- Who is your medical reviewer (endocrinologist + psychiatrist)? Can we list "Reviewed by Dr. X" in app? Legal disclaimer lawyer for Egypt/Saudi stores?
- Red-flag hotlines per country to include (Egypt 105? Saudi 937? UAE?)?

## Q10. Business & Launch
- Free vs freemium vs paid? Ads? NEVER supplement ads — confirm.
- Launch countries first? Egypt only then MENA? Store accounts ready (Apple Developer / Google Play)? Deadline / budget?

## Q11. Animation & 3D
- 3D Body/Brain toggle wanted MVP or V1? Mascot style? Reduced-motion OK? Performance floor (which test phones)?

## Q12. Success Definition
- What does "best in Middle East" mean to you in numbers? (downloads, rating, retention?) What is the ONE screen that must wow in 10 seconds?

---
**How to answer:** Reply numbered Q1-Q12, even with "decide for me with reason" if you want proposal. Nothing will be assumed silently — every decision will be logged in config + changelog.
