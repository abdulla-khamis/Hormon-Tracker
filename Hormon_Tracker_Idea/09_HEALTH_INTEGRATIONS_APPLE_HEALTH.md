# 09 - Health Integrations (LOCKED: ON-DEVICE ONLY, 2026-09-05)

Owner lock: health samples NEVER leave the device in MVP/V1. Even logged-in users: HealthKit/Health Connect → Hive local → estimation engine local. Cloud backup uploads only daily estimates + manual inputs, never raw sleep/HR/HRV rows (`health_upload:false`).

## What We Read (Only With Consent, Granular)
- Sleep: total, deep/REM if avail, bedtime/wake consistency → melatonin/cortisol/serotonin proxies.
- Activity: steps, active energy, workouts (type+minutes+HR) → dopamine/endorphins/cortisol.
- Heart: resting HR, HRV (RMSSD/SDNN), VO2max → stress/recovery proxy for cortisol.
- Body: weight, BMI trend (optional) → leptin/insulin context (never diagnose).
- Nutrition (if user logs in Apple Health): caffeine, sugar, water → cross-check manual food log.
- Mindfulness minutes (Apple) → serotonin/cortisol bonus.
- Cycle (HealthKit Cycle Tracking, optional, explicit): adjusts energy_sex/serotonin baselines, with clear label.

## What We NEVER Claim
- No watch measures dopamine/serotonin/cortisol directly. HRV/RHR/sleep are STRESS/SLEEP proxies, not hormone blood values.
- Show "Synced 2h ago • Sleep 5h40 • HRV 38ms → Estimated Cortisol Trend: High (low confidence if single source)".
- If no wearable: manual check-in alone still works (confidence Low → Medium as history grows).

## Platform Details
- iOS: HealthKit via `health` plugin, NSHealthShareUsageDescription ar/en, background delivery for sleep/workouts, Sign in with Apple.
- Android: Health Connect (steps, sleep, exercise, HR/HRV), Google Fit migration note, runtime permissions, Samsung Health via Health Connect where supported, Huawei Health Kit optional V1+ (region-dependent).
- Sync: on launch + nightly job, deduplicate by source+startTime, store `source` + `version` for audit, user can disconnect/delete per GDPR.
- UX: permission primer screen BEFORE system dialog (why each type helps which hormone), "Skip, I'll log manually" always available.
- Edge: Ramadan night-shift sleep, shift workers, teens/elderly — adjust baselines, warn about circadian disruption, suggest consistent wake + light.

## Accuracy & Safety
- Confidence engine: Manual only = Low; +wearable fresh (<24h) = Medium; +7 days history = High (still estimate).
- Outlier guard: if Health sleep = 0 due to missing permission → ignore, don't penalize score, show "No sleep data".
- Doctor PDF includes: inputs + health summaries + engine version + disclaimer watermark, never raw HR as diagnosis.
