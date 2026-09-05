# 08 - UI/UX, Animation and 3D Guide (Interactive + Friendly)

## Personality
Encouraging coach, never doctor-scary. Mascot: friendly brain-drop character that changes face with balance (happy/calm/tired). Tone ar/en: "Great step! Your calm estimate improved." Never: "Your hormones are dangerous."

## The ONE Unified Chart (Mandatory Reuse)
Widget name: `HormoneBalanceChart` — used in Home, Detail, Library (typical pattern), History, Doctor PDF.
- Props: `scores: Map<hormoneId, 0-100>`, `mode: bars|line|mini`, `highlightId?`, `locale`, `showWhyChips`.
- Visual: 7 vertical rounded bars, animated height (spring 600ms), gradient fill, icon on top, value pill, Low/Balanced/High label from i18n + thresholds.json.
- Cortisol inverted color logic (high = amber/red, low-mid = green) via `invert` flag in hormones.json, not if-else in UI.
- Accessibility: semantic labels, haptic on tap, min touch 48px, color-blind safe + patterns + labels (not color alone).
- Empty/low-confidence: dashed outline + "Add 2 more inputs for better estimate".

## Animations (Smooth, Purposeful, 60fps)
- Bars morph on submit (staggered 80ms each), number count-up, confetti on "back to balanced", breathing glow on cortisol-high card suggesting breathing exercise.
- Transitions: shared-element from bar → detail, hero mascot, page slide respecting RTL (slide from correct side).
- Libs: Rive (mascot + empty states) + Lottie (celebrations) + implicit animations first; no heavy video.
- Reduced motion: respect OS setting → disable 3D/confetti, keep fades.
- Tokens: `anim.fast/med/slow` shared, no hardcoded durations.

## Light 3D (Delight, Not Gimmick, Toggleable)
- Toggle: [Bars | 3D Body/Brain] on Home. 3D shows stylized low-poly brain + body with glowing spots per hormone (e.g. heart for oxytocin, head for dopamine/serotonin/melatonin, adrenals for cortisol). Tap spot → same detail sheet as bars.
- Tech: `model_viewer_plus` / `flutter_3d_controller` with 2 optimized .glb (<3MB), fallback to bars on low-end or reduced-motion.
- No medical realism claim: label "Illustrative, not anatomical".
- Performance: lazy-load 3D, cache, 30fps cap, off by default on <3GB RAM or battery saver.

## Screens Polish Checklist
- Home loads <1.5s offline, skeleton bars shimmer, Arabic line-height 1.6, no overflow at 320px + 1.3x font.
- Dark mode: bars glow subtly, 3D dims, contrast AA.
- Friendly microcopy bank in i18n (encouragement, no shame, Islamic tone optional).
- All icons from single set (e.g. Phosphor/Lucide) via config names, mirrored for RTL where needed.
