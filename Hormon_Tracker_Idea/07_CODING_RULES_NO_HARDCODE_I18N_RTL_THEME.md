# 07 - Coding Rules: No Hardcode, i18n, RTL, Theme (STRICT)

Violating any rule = PR rejected. CI enforces.

## 1. ZERO HARDCODE
1.1. No literal UI strings in code. Use `context.l10n.key` / `S.of(context)`. Keys in `lib/l10n/en.arb`, `ar.arb`.
1.2. No hormone/activity/food/tip names, descriptions, deltas, thresholds in code. Load from `assets/config/v1/*.json` via `ConfigRepo` + Remote override.
1.3. No color hex, font size, radius, spacing in widgets. Use `AppTheme.of(context).colors/spacing/typography`. Themes in `core/theme/app_tokens.dart` + `light_theme.dart` + `dark_theme.dart`.
1.4. No image path strings scattered. Use `AppAssets` constants + config-driven icon names.
1.5. No API URLs, keys in code. Use `--dart-define` + env + backend config. Secrets in native keystore, never git.
1.6. Dates/numbers formatted via `intl` with locale, Hijri via helper, never manual `${day}/${month}`.
1.7. Lint: `avoid_hardcoded_strings` custom rule + `flutter analyze` + Danger check fails if `Text("` with literal found in `features/**/ui`.

## 2. BILINGUAL ar/en (Correct Medical Arabic, Not Literal)
2.1. English is source, Arabic reviewed by doctor + linguist. EXCEPTION (owner lock): brand name `Horman Tracker` NEVER translates — `app_title` is identical Latin in en+ar. Glossary (stored in `assets/lang/glossary.csv`):
- Dopamine → دوبامين, Serotonin → سيروتونين, Oxytocin → أوكسيتوسين, Endorphins → إندورفين, Cortisol → الكورتيزول (هرمون التوتر), Melatonin → ميلاتونين, Testosterone → تستوستيرون, Estrogen → إستروجين, Insulin → إنسولين, Thyroid → الغدة الدرقية, Adrenaline → أدرينالين.
2.2. Never machine-translate medical content OTA without review flag `reviewed:false` → shows English fallback + "Arabic review pending".
2.3. Pluralization, gendered verbs (Arabic masculine/feminine) via ICU messages, profile-aware (e.g. "أنتِ" vs "أنتَ" based on profile, default neutral).
2.4. All tips/content have `en` + `ar` fields; missing `ar` = CI warning.

## 3. RTL + LTR Layout
3.1. Use `Directionality` from locale, `EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional`. FORBIDDEN: `EdgeInsets.only(left:)`, `Alignment(left)`.
3.2. Bottom nav, charts, FAB mirror correctly. Chart Y-axis labels flip side in RTL. Test with golden screenshots `en` + `ar`.
3.3. Icons that imply direction (back, send, chart arrow) use `matchTextDirection:true` or RTL variants.
3.4. Numbers/charts stay LTR inside (scores 0-100) even in Arabic, with Arabic labels outside. Use `Directionality(ltr)` wrapper for bars row if needed, verified by UX.
3.5. QA checklist: switch language live without restart, layout no overflow at 320px + large font (accessibility 1.3x).

## 4. SHARED THEME
4.1. Single `AppTheme` for both languages. Colors semantic: `balanced`, `low`, `highAlert`, `cortisolHigh` (inverted). Dark mode contrast AA.
4.2. Typography: Arabic font (e.g. IBM Plex Sans Arabic / Tajawal) + Latin font (Inter) via fontFamilyFallback, line-height 1.6 for Arabic.
4.3. Spacing scale 4/8/12/16/24, radius 12/20, no magic numbers.
4.4. Animation durations in tokens: `fast 150ms, med 300ms, slow 600ms`.

## 5. File/Naming/Formatting
- Files: `snake_case.dart`, widgets `PascalCase`, l10n keys `snake_case`, config ids `snake_case`.
- `dart format`, `eslint/prettier` if RN, conventional commits, PR template includes: screenshots ar+en, config version, doctor-impact? yes/no.

## Example (Flutter - DO / DON'T)
// DON'T:
// Text("Dopamine", style: TextStyle(color: Color(0xFF00FF00)))
// Bar(value: 72) // magic
// DO:
final h = config.hormoneById('dopamine');
Text(context.l10n.hormoneName(h.i18nKey), style: AppTheme.of(context).typography.title);
HormoneBalanceChart(scores: state.scores, config: config) // scores from engine, labels from l10n
