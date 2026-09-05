# 01 - Product Vision and Scope

## One-line Vision
> The friendliest MENA app that helps you **understand** how your day affects your hormones, and **what to do/eat** to return to balance — in simple bars, not lab jargon.

App name (locked by owner): **Horman Tracker** — brand spelling kept as owner requested, even though medical English is Hormon/Hormone. Arabic name TBD.

## Problem
- Hormone info is complex, scary, English-only, or pseudoscience on TikTok.
- Arabs have no simple, Islamic-aware, bilingual tracker linking: sleep, food, sport, stress, prayer, fasting → mood/energy/sleep.
- Wearables collect data but never explain "what does this mean for my dopamine/cortisol?"

## Target Users (V1)
1. 18-40 MENA youth, Arabic or English, interested in energy/mood/sleep/focus.
2. Gym / diet / productivity people.
3. Fasting / religious users who want Salah/Dua/Fasting integrated respectfully.
4. NOT for: diagnosed endocrine patients seeking treatment, pregnant without doctor, children <13 without guardian. These need disclaimers.

## Core Promise (3 taps)
1. Open app → see **today's estimated hormones** as bars (high / balanced / low).
2. Input what you did/ate/felt OR auto-sync from Apple Health → bars update instantly.
3. Tap any hormone → see **"To rebalance: do X / eat Y / avoid Z"** + **"If you feel like this, your hormones look like this"** library.

## Scope IN (MVP)
- 7 core estimated indicators + Hunger/Stress extension (owner locked): Dopamine, Serotonin, Oxytocin, Endorphins, Cortisol, Melatonin, Energy-Sex axis (Testosterone/Estrogen cycle-aware) PLUS Insulin/Ghrelin/Leptin (hunger/satiety group), Adrenaline, GABA.
- Islamic practices (Salah, Dhikr, Fasting) are NOT a separate section — they are input factors with deltas exactly like food/sport (owner locked). E.g. `fasting_day` or `salah_any` modifies hormones same engine as `coffee` or `run_30min`.
- Daily check-in: 8-12 most common actions/states (config-driven, not hardcoded).
- Food quick-log: 20-30 common MENA foods/drinks (config-driven).
- Single unified `HormoneBalanceChart` used in Home, Result, History, Library.
- Rebalance tips engine: action tips + food tips + Islamic practice tips (optional, respectful).
- Feel-state library: e.g. "Anxious / Can't sleep / No motivation / Craving sugar" → shows typical pattern + what helps.
- Bilingual ar/en, RTL, light/dark + shared theme, smooth animation + light 3D.
- Health sync: sleep, steps, workouts, heart rate, HRV, resting HR (proxies only).

## Scope OUT (Explicitly NOT)
- NOT a lab device. Never show ng/dL, pg/mL as if measured. Only 0-100 Balance Index + Low/Balanced/High labels.
- NO diagnosis (e.g. "you have depression / hypothyroidism").
- NO drug prescription, NO supplement dosage, NO hormone therapy advice.
- NO claiming prayer cures disease. We say: "associated with stress reduction in studies, supports calm/routine".
- NO hardcoded strings, colors, hormone lists, tips.

## Success Metrics (to confirm)
- Day-7 retention > 25%, check-in completion < 60 sec, tip helpfulness rating, no medical complaints.
- MENA store rating 4.7+, Arabic UX praised for correct terms + RTL.

## Name / Branding TODO
- Confirm final spelling: Hormon vs Horman vs Hormone Tracker.
- Logo, mascot (friendly brain/body), tone: encouraging, never scary, never shaming.
