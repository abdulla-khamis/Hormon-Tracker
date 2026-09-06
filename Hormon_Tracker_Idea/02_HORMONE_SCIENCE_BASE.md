# 02 - Hormone Science Base (Doctor Review - 20Y Endocrinology View)

> WARNING: This app is EDUCATIONAL. It estimates TRENDS, never measures blood hormones.
> Any persistent symptoms → lab test + endocrinologist. This file prevents pseudoscience.

## 1. What Hormones Really Are
Chemical messengers from glands → blood → organs. They control metabolism, sleep, mood, appetite, stress, reproduction. Brain neurotransmitters (dopamine, serotonin, endorphins, GABA) overlap with hormones in function but are mostly synaptic, not blood. App must label clearly: "Brain chemicals + Body hormones".

Source: Harvard Health (feel-good hormones, 2024), Cleveland Clinic (happy hormones, 2025), AJBP review 2025.

## 2. MVP Core 7 + Hunger/Stress Extension (Owner Locked 2026-09-05)

| ID | EN | AR (correct, not literal) | What user feels | Main natural influencers |
|----|----|---------------------------|-----------------|--------------------------|
| dopamine | Dopamine | دوبامين | motivation, reward, focus | Novelty, goals, exercise, sunlight, excess sugar/social media spikes then crash, sleep loss lowers it |
| serotonin | Serotonin | سيروتونين | calm, mood stability, sleep/appetite | Sunlight 15-30min, aerobic exercise 30min x5/week, complex carbs + tryptophan foods, meditation, nature walk, social contact |
| oxytocin | Oxytocin | أوكسيتوسين | bonding, trust, calm | Hugs, kindness, petting animals, group activity, prayer in congregation, family meal |
| endorphins | Endorphins | إندورفين | natural pain relief, euphoria after effort | Vigorous exercise, laughter, dancing, massage, dark chocolate (modest) |
| cortisol | Cortisol (Stress hormone) | الكورتيزول (هرمون التوتر) | alertness; chronic high = anxiety, belly fat, bad sleep | Chronic stress/sleep loss/caffeine raise; mindfulness, breathing, prayer, nature, sleep hygiene, moderate exercise lower; follows circadian: peak 6-7am, lowest midnight |
| melatonin | Melatonin | ميلاتونين | sleep onset, circadian rhythm | Darkness triggers; screen light at night suppresses; regular sleep/wake + Fajr routine + sunlight morning help; fasting shifts rhythm |
| energy_sex_T | Testosterone | تستوستيرون | drive, strength, vitality | Sleep 7-9h, resistance training, healthy fats; smoking/stress disrupt |
| energy_sex_E | Estrogen | إستروجين | mood, cycle, vitality balance | Sleep regularity, stress control; chronic stress/sleep loss disrupt |

Advanced (V1+, education only, no lab claim):
- Hunger group (MVP per owner): Insulin / Ghrelin / Leptin visualized as one "Appetite Balance" cluster or 3 mini-bars (UX to confirm, same chart component).
- Stress group (MVP per owner): Adrenaline (fight-flight spikes) + GABA (calm brake).
- Later: TSH/T3/T4 (thyroid — NEVER estimate from lifestyle, only education + "see doctor"), Prolactin, Growth Hormone (deep sleep), BDNF (exercise, stress).

## 3. Key Evidence Rules for Estimation Engine
- Exercise is #1 trigger for all 4 happy chemicals at once (Cleveland Clinic) + lowers cortisol via HPA regulation + improves sleep.
- Sunlight + nature: ↑ serotonin, ↓ cortisol/adrenaline.
- Sleep loss: ↑ cortisol, ↓ dopamine/serotonin, disrupts ghrelin/leptin (hunger up).
- Diet: tryptophan (eggs, dairy, nuts, turkey) + complex carbs → serotonin pathway; tyrosine (protein) → dopamine; excess sugar/caffeine/alcohol → spike/crash + cortisol/sleep harm. Phytochemicals/polyphenols + exercise synergistic (2025 reviews) but NO supplement dosage in app.
- Mindfulness/breathing/yoga/cold shower/massage: parasympathetic → ↓ cortisol, ↑ serotonin/endorphins.
- Social/kindness/pets/hobbies: ↑ oxytocin/serotonin/dopamine.

## 4. What We MUST NOT Do (Medical Safety)
1. Never display fake lab units. Use `Balance Index 0-100` + `Low <40 / Balanced 40-70 / High >70` (thresholds in config, adjustable, with medical review).
2. Never say "Your cortisol is 22 mcg/dL". Say "Estimated Cortisol Trend: High — based on poor sleep + high stress inputs".
3. Thyroid/Prolactin/Testosterone disorders need labs. App shows lifestyle trend only + banner: "This is not a diagnosis. See doctor if symptoms persist >2 weeks".
4. Pregnancy, breastfeeding, PCOS, diabetes, thyroid, depression, on SSRIs/antipsychotics/steroids → special disclaimer + encourage doctor, disable aggressive tips (e.g. fasting/exercise intensity).
5. Supplements (5-HTP, melatonin pills, DHEA): NO recommendation. Only "talk to doctor/pharmacist".
6. Children, elderly baselines differ — use age-group config, not one-size.

## 5. Default Baselines (Config, Not Hardcode)
- Every hormone starts at `baseline = 50` (balanced) per 24h reset, adjusted for: sleep debt, age group, sex, cycle phase, chronic stress flag (all from profile + HealthKit if permitted).
- Each logged activity/food/state applies `delta -15..+15` per hormone with decay over time. Weights live in `hormone_weights.json`, versioned, reviewable by doctor, updatable OTA without app release.
- Example (illustrative, doctor must approve final numbers): `aerobic_30min: {dopamine:+10, serotonin:+8, endorphins:+12, cortisol:-8, melatonin_sleep_tonight:+5}`.
- Confidence label: Low/Medium based on data completeness (e.g. only 2 inputs = Low confidence).

## 6. Doctor Validation Checklist Before Launch
Owner state (2026-09-05): NO doctor reviewer available. Therefore NO-DOCTOR MODE is mandatory:
- [ ] Deltas capped ±8, only strong/moderate evidence rows ship; preliminary rows show "early evidence" badge or stay hidden behind `show_preliminary:false`.
- [ ] Every tip links to sourceId (§11) + evidenceLevel; no doses, no lab-unit claims, no disease promises.
- [ ] Legal medical disclaimer in ar/en on first launch + detail screens + PDF (lawyer/owner approved, not doctor).
- [ ] Safety surfaces: first-launch disclaimer + Methods & Limits page + per-screen estimate note (no SOS section per owner lock).
- [ ] Public "Methods & Limits" page in-app: we estimate trends, labs are truth, see doctor for symptoms.
- [ ] Future: recruit endocrinologist + psychiatrist before any diagnostic/lab-integration claim (V2 gate).
