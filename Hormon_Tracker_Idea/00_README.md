# Hormon Tracker - Idea Folder - README

This folder is the single source of truth for the **Hormon Tracker** mobile app idea.
All files are in English because they are engineering rules and product specs.
No code yet. No assumptions. Everything here must be validated by the owner + medical reviewer.

## File Map

- `01_PRODUCT_VISION_AND_SCOPE.md` - What the app is, who it is for, what it is NOT.
- `02_HORMONE_SCIENCE_BASE.md` - Medically safe hormone list, what we estimate vs what we never claim.
- `03_ISLAMIC_SOURCES_AND_LIFESTYLE_IMPACT.md` - Salah, Dua/Dhikr, Fasting, with scientific correlation and limits.
- `04_USER_JOURNEY_AND_APP_FLOW.md` - Simple flows: check-in, auto-sync, hormone bars, rebalance tips, feel-like-this page.
- `05_DATA_MODEL_AND_ESTIMATION_ENGINE.md` - No-hardcode config model + estimation formula. Baselines are editable, not hardcoded.
- `06_TECH_STACK_AND_ARCHITECTURE.md` - Proposed stack (to be confirmed by owner, no assumption locked).
- `07_CODING_RULES_NO_HARDCODE_I18N_RTL_THEME.md` - Strict rules: zero hardcode, ar/en, RTL, shared theme.
- `08_UI_UX_ANIMATION_3D_GUIDE.md` - One unified chart everywhere, friendly, interactive, smooth animation + 3D.
- `09_HEALTH_INTEGRATIONS_APPLE_HEALTH.md` - Apple HealthKit / Google Health Connect / Huawei / Samsung. What we read, privacy, accuracy limits.
- `10_ROADMAP_MVP_TO_V1.md` - Phased roadmap to become best in MENA without medical errors.
- `11_SOURCES_AND_REFERENCES.md` - All medical, Islamic, technical sources.
- `12_OPEN_QUESTIONS_DO_NOT_ASSUME.md` - Blocking questions for owner. Nothing proceeds on guess.
- `13_AUTH_AND_GUEST_MODE.md` - Login optional, guest-first auth, upgrade with zero data loss.
- `14_MENA_HABITS_AND_FOODS_CONFIG_DRAFT.md` - 12 habits + 25 MENA foods draft (owner approved direction).
- `15_COSTS_AND_MONETIZATION_AND_LAUNCH.md` - Free-first-month costs + launch plan.

## Golden Principles

1. **We do NOT measure hormones.** We show an **Estimated Balance Index (0-100)** based on lifestyle inputs + wearable proxies. Lab test is the only real measurement.
2. **Medical safety first.** No diagnosis, no prescription, no dosage. Always "consult doctor" disclaimer.
3. **Zero hardcode.** Hormones, activities, foods, tips, weights, baselines, strings, colors all come from config / backend / localization files.
4. **Arabic is not literal translation.** Use correct medical Arabic terms + RTL + shared theme.
5. **One chart everywhere.** Same `HormoneBalanceChart` component in all screens, only values change.
6. **Ask, don't assume.** If unclear, add to `12_OPEN_QUESTIONS` and ask owner.
