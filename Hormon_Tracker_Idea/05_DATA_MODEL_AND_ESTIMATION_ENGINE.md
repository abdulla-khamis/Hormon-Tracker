# 05 - Data Model and Estimation Engine (Zero Hardcode)

## Principle
Nothing medical or textual is hardcoded in Dart/Kotlin/Swift. Everything lives in versioned JSON/Remote Config + i18n files. App ships with bundled fallback `assets/config/v1/*.json` + OTA update via backend.

## Config Files (bundled + remote override)
- `hormones.json`: id, enName, arName (medical correct), icon, colorLow/Balanced/High, description_en/ar, invert flag (cortisol high=bad), unit label "Balance Index".
- `activities.json`: id, icons, en/ar labels, deltas per hormone, duration, tags (sport, worship, social...), evidenceLevel (strong/moderate/preliminary), sourceIds.
- `foods.json`: MENA list + caffeine/sugar grams, deltas, portion.
- `feel_states.json`: feeling id → typicalPattern (7 values for library demo) + help tipIds.
- `tips.json`: tipId, hormoneIds, type (do/eat/avoid/islamic), en/ar text, duration, evidenceLevel, sourceIds, contraindications (pregnant/diabetic...).
- `weights.json`: delta values + decay half-life + baseline modifiers (age/sex/cycle/sleepDebt). Doctor-versioned e.g. `weights_v1.3_doctorApproved`.
- `thresholds.json`: low<40, balanced 40-70, high>70 (tunable), confidence rules.
- `strings`: `en.json`, `ar.json` via standard i18n (flutter_localizations / i18next). No string literal in UI code (lint enforced).

## Core Entities (SQLite / Hive / Room + Backend Postgres/Supabase)
- `UserProfile`: id, locale, theme, sex, ageGroup, cycleOptIn, conditionsFlags (for safety only), showIslamicTips, healthSyncEnabled.
- `DailyInput`: date, sleepHours, sleepQuality, activities[ids+minutes], foods[ids+portions], feelings[ids], prayer {fajr..isha bool, dhikrMin, quranMin, fasting bool}, cycleDay (optional), notes.
- `HealthSample`: date, source (healthkit/healthconnect), steps, sleepMin, deepSleepMin, workouts[], restingHR, hrvRmssd, vo2max (if avail).
- `HormoneEstimate`: date, hormoneId, score 0-100, confidence Low/Med/High, topContributors [inputIds], isAuto (health) vs manual.
- `TipInteraction`: tipId, liked/disliked, done.

## Estimation Formula (Transparent, Reviewable)
```
score_h = clamp(0,100, baseline_h(profile, cycle, sleepDebt, age/sex)
  + SUM(delta_h(input_i) * recencyDecay(hoursSince))
  + SUM(proxy_h(healthSample))   // e.g. poor sleep: cortisol+10, melatonin-12
  + noise_guard)                // no random, deterministic
confidence = f(countInputs, healthSyncFreshness, daysHistory)
```
- `baseline_h` default 50, modified max ±10 by profile (e.g. luteal phase serotonin -5, teen dopamine variability flag).
- `proxy_h` examples (doctor-approved ranges): sleep<6h → cortisol +10, serotonin -8, melatonin rhythm -10; HRV low + RHR high + self-reported stress → cortisol +8; 30min aerobic → endorphins +12, dopamine +10, cortisol -8; sunlight → serotonin +7.
- Decay: inputs decay 50% every 18h so yesterday matters less.
- Cycle-aware: if cycleOptIn, follicular vs luteal adjusts energy_sex/serotonin baselines ±6 with clear label "cycle-adjusted estimate".
- All deltas in `weights.json`. Algorithm version stored per estimate (`engine_v1`) for audit.

## Anti-Hardcode Enforcement
- Lint: no string literals in `lib/ui`, no `Color(0x...)` hex in widgets (use `AppTheme.of`), no hormone name in code (use `hormone.id` + localization).
- Codegen: `flutter gen-l10n` / `typesafe-i18n`. CI fails on hardcoded Arabic/English in UI folder.
- Remote Config (Firebase/Supabase): can tune weights/thresholds/tips without store release + phased rollout + kill-switch for any tip.

## Privacy
- Health data on-device first, explicit consent per type, revoke anytime, no selling, anonymized analytics only, GDPR + MENA data residency to confirm.
