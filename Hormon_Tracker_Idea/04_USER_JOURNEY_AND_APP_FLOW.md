# 04 - User Journey and App Flow

## Design Goal
Enter → understand in 10 seconds → act in 60 seconds. Friendly, no fear, lots of smooth feedback.

## Personas
- Salma (24, Cairo, designer, poor sleep, high screen time).
- Omar (31, Riyadh, gym, wants energy/focus, fasts Mon/Thu).
- Layla (29, Amman, new mom, mood swings — needs gentle + doctor nudges).

## Core Flows

### A. First Launch (Onboarding, <90 sec, skippable)
1. Language: English / العربية (RTL preview instantly).
2. Goal picker (config-driven): Sleep / Mood / Energy / Focus / Stress / Balance all.
3. Profile (optional, editable): age group, sex, cycle tracking opt-in, conditions (diabetes/thyroid/depression/meds/pregnant) → only to tailor disclaimers, never to diagnose.
4. Health connect permission (optional): Apple Health / Health Connect — explain WHY (sleep, steps, workouts, HR/HRV) + privacy. Separate from login — works in guest mode.
5. Login card (optional, skippable, guest-first): "Continue as Guest →" primary, "Log in / Back up" secondary. See `13_AUTH_AND_GUEST_MODE.md`. Must tap "I understand" for estimation disclaimer (works for guest too).

### B. Home - Today's Hormones (Main Screen)
- Top: greeting + date (Gregorian + Hijri if enabled) + sync status + confidence badge (Low/Med/High).
- Center: `HormoneBalanceChart` — 7 vertical bars with color (low=blue, balanced=green, high=amber/red for cortisol inverted) + friendly face/mascot reacting.
- Under: "Why?" chips (e.g. "Short sleep 5h", "No sunlight", "Prayed Fajr") tapping chip explains delta.
- CTA: [+ Log day] + [Sync health] + [How to rebalance?].

### C. Log Day (Check-in)
- Step 1 - How do you feel? (multi-select feelings config): Anxious, Low energy, Can't focus, Sad, Irritable, Craving sugar, Can't sleep, Motivated, Calm, Energetic.
- Step 2 - What did you do? (most common, icons): Sleep hours+quality slider, Workout (walk/run/gym/yoga), Sunlight 15min, Prayer/Dhikr/Quran minutes, Social time, Meditation/breathing, Screen 4h+, Work stress event.
- Step 3 - What did you eat/drink? (MENA quick list): Coffee 1/2/3+, Sugar/soda, Fast food, Dates/honey moderate, Nuts, Eggs/dairy, Fish, Veggies/fruits, Dark chocolate, Water L, Fasting today?
- Submit → animated bars morph + confetti if balanced + "See rebalance plan".

### D. Hormone Detail (Tap any bar)
- Same mini-chart highlighted + plain explanation: what it does, why yours is high/low today, what influences it.
- Tabs: [Rebalance: Do] [Eat/Drink] [Avoid] [Islamic gentle habit if enabled].
- Each tip: icon, 1-line action, duration, expected effect (e.g. "+Serotonin"), source link. Like/dislike to personalize (stored, no hardcode).

### E. Feel-State Library ("If you feel X, hormones look like Y")
- Grid of states → tapping shows TYPICAL pattern chart (educational template from config, labeled "Typical example, not your diagnosis") + 3 top actions.
- Examples: Panic before exam (cortisol/adrenaline high, serotonin low), 3am scrolling (melatonin low, dopamine spiky, cortisol up morning), Post-workout glow (endorphins/dopamine high), Lonely weekend (oxytocin/serotonin low) → suggest call family, mosque/community, pet, kindness act.

### F. History & Insights
- Weekly curves (same chart style, line mode), streaks (sleep, movement, prayer logging — no guilt design), correlation cards: "When you walk + pray Fajr, your next-day calm is +18% (n=12 days)".
- Export PDF for doctor (estimated trends + inputs, with disclaimer watermark).

### G. Safety Intercepts
- Red flags (suicidal ideation, chest pain, fainting, severe depression >2wks, cycle absent 3mo, galactorrhea, etc.) → full-screen care card: "Please seek care now" + hotlines (config per country) + disable tips.
- Persistent out-of-balance >14 days → "Consider lab check + doctor" nudge.

## Navigation (Bottom Tabs, RTL-aware)
Home (bars) | Log (+) center FAB | Library (feel-states) | Insights (history) | Settings/Profile.
All labels from i18n, icons mirrored correctly in RTL, FAB stays centered.
