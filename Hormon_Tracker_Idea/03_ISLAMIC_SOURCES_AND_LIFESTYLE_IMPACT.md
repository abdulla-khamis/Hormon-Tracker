# 03 - Islamic Sources and Lifestyle Impact (Respectful + Evidence-Based)

> Owner lock (2026-09-05): Islamic practices are INPUT FACTORS like food/sport, NOT a separate section/tab. Engine treats `salah_any`, `dhikr_10min`, `fasting_day` with deltas exactly like `coffee` or `run_30min`. No religious scoring, no dedicated worship tab design.

## 1. Principles
1. Islamic practices are worship first, wellness second. App tone: respectful, optional, non-preachy, no fatwa. Link to trusted scholars for fiqh, doctors for health.
2. Every Islamic tip shows TWO lines: (a) Islamic source (Quran/Sunnah), (b) What science observed (with limits + citation).
3. User can disable religious content in settings (config flag `show_islamic_tips`).
4. No tracking of "prayer quality (khushu)" as score to avoid guilt. Only gentle logging: prayed / dhikr minutes / Quran minutes / fasting day.

## 2. Salah (5 Daily Prayers)
**Islamic base:**
- "And establish prayer for My remembrance." (Quran 20:14)
- "Surely in the remembrance of Allah do hearts find rest." (Quran 13:28)
- Movements: Qiyam, Ruku, Sujud, Julus — regular, calm, breath-aware.

**What studies observed (2022-2025 systematic reviews):**
- Sobhani et al., J Med Life 2022 (n=83): 4 rak'ahs (~5 min) moved high cortisol DOWN and low cortisol UP toward optimal range; alpha-amylase same normalizing pattern. First finding, needs replication, no control group — must state limit.
- Shaverdi et al., JMR 2024 (n=82, HRV ECG): SD1/SD2 Poincaré increased post-prayer; sympathetic tone lower in bowing/prostration vs standing/sitting → improved cardiovascular flexibility, stress relief.
- Al-Shawki preprint 2025 (n=35, EEG + salivary cortisol): alpha/theta coherence prefrontal-parietal ↑ (p<0.01), cortisol -27.3% post-prayer sustained 30 min, PSS stress score improved. Preprint — label as preliminary.
- JRHS systematic review 2009-2024: Salah associated with stress reduction, balance in elderly, cardio regulation, but heterogeneous methods → cautious interpretation.
- Psych: Salah regularity predicts better stress management (r=0.42, Indonesian students 2024); restorative effect via attention restoration + stress restoration theories; sujud + Quran recitation show strongest relaxation/focus signals.

**App mapping (conservative):**
- `salah_fajr/dhuhr/asr/maghrib/isha` or `salah_any`: cortisol -6 to -10, serotonin +5, GABA/calm proxy +6, dopamine +3 (routine accomplishment). Congregation/jama'a: oxytocin +5. Night Tahajjud (see below) separate.
- Tip copy example: "Salah break: 5 calm minutes. Studies observed lower stress markers after prayer. Take slow breaths between movements."

## 3. Dua, Dhikr, Quran Recitation/Listening
**Islamic base:** Dua is worship; Dhikr calms heart (13:28); Quran as healing/mercy (17:82 — present as spiritual, not medical claim).

**Science proxy:** Meditation/mindfulness literature: 10-min diaphragmatic breathing + 21-day mindfulness ↑ serotonin metabolites, ↓ cortisol, ↑ alpha waves, ↑ HRV nuHF (parasympathetic). Salah+Quran recitation > mimed movements for focus/alpha (Doufesh et al.). App treats Dhikr/Quran as mindfulness-like: cortisol -5, serotonin +5, melatonin sleep prep +4 if night.

**App mapping:** `dhikr_10min`, `quran_15min` as separate loggable habits. No auto-detection. Respectful streaks, no guilt.

## 4. Fasting - Ramadan + Voluntary (Mon/Thu, White Days)
**Islamic base:** Ramadan fasting dawn→sunset (one of Five Pillars); voluntary fasts Sunnah. Include Suhoor/Iftar balance, hydration, sleep guidance. Exemptions (illness, pregnancy, menstruation, travel) MUST be in-app + "consult doctor/scholar".

**What meta-analyses show:**
- Poursalehian et al., PLOS ONE 2024 (35 studies, n=1107): NO significant change in T3/T4/TSH, Testosterone/LH/FSH/Prolactin; morning cortisol trend DOWN (g=-2.14, p=0.08, ns) + evening cortisol UP — circadian shift due to night eating/sleep change. Conclusion: minimal hormonal change, safe for healthy non-athletes.
- Al-Rawi et al., PLOS ONE 2020 (overweight/obese, n=57): ghrelin -19%, leptin -13%, melatonin -39% daytime, salivary cortisol unchanged; weight/BMI/fat down, HDL up.
- Riat et al., Front Nutr 2021 (17-18h Germany): cortisol ↓ 1wk post-Ramadan then back to baseline 1mo; BDNF ↓ end-Ramadan; mood/QoL improved via multiple mediators.
- Chennaoui et al. athletes: fatigue ↑, melatonin ↓, adrenaline/noradrenaline/IL-6 ↑ during Ramadan, performance (MAV) ↓, all recovered 1wk post. Implication: reduce intense load + daytime nap for athletes.
- Tahajjud RCT, Yusni 2024 (healthy young men, 11 rak'ahs 20-35min, 3-7x/wk x6wks): cortisol -8.9%, glucose -19.7% vs control (p<0.05). Small n=20 — promising, needs larger trials.

**App mapping:**
- During Ramadan mode: shift cortisol curve (morning lower, evening higher), adjust melatonin (sleep disruption risk), ghrelin/leptin hunger logic, insulin sensitivity tip. Show "Ramadan Balance Mode" banner + sleep/nutrition tips, not hormone diagnosis.
- `fasting_day`: insulin Need ↓ (good), ghrelin wave, cortisol neutral-to-slight ↑ if dehydrated/sleep-deprived → advise hydration/sleep.
- Never encourage fasting for: diabetics on meds, pregnant, eating disorders, underweight, kidney disease without doctor.

## 5. Wudu, Tahajjud/Fajr Routine, Community
- Wudu (ablution): present as refreshing routine + cold-water vagal brief stimulus (cold exposure 2-3min literature) — modest, no overclaim. Cold face wash → alertness.
- Tahajjud/Fajr: early waking + light exposure + quiet prayer → circadian anchor (morning light ↑ serotonin, night darkness ↑ melatonin). Cite cortisol circadian control (SCN). Encourage consistent wake time.
- Jumu'ah / family meals / kindness (sadaqah): oxytocin/serotonin social pathway.

## 6. Content Rules
- Every Islamic card: source Arabic + translation + scholar-friendly wording + study citation + "Allah knows best, health is trust (amanah)".
- Review by: Islamic scholar (authenticity) + doctor (health wording) + native Arabic editor (terms).
- Config: `islamic_practices.json` — enable/disable per region, Ramadan auto-dates via Hijri lib (no hardcode).
