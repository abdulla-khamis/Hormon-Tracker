# 14 - MENA Habits and Foods Config Draft (Owner Approved Direction 2026-09-05)

Owner approved the proposed direction (coffee, shisha, late nights, gaming, social + koshary, dates, arabic coffee, karkadeh...). Below is the locked V1 draft. All IDs config-driven. Deltas are CONSERVATIVE educational estimates from literature (§11), flagged `review: pending_no_doctor` — see file 02 safety rules for no-doctor mode.

## A. 12 Daily Habits (activities.json draft)

| id | EN | AR (correct) | Category | Proposed deltas (doctor-unreviewed, conservative ±3..8) |
|----|----|--------------|----------|--------------------------------------------------------|
| sleep_short | Short sleep <6h | نوم قصير أقل من 6 ساعات | sleep | cortisol +8, serotonin -6, dopamine -5, melatonin_rhythm -8, GABA -4 |
| sleep_good | Good sleep 7-9h | نوم جيد 7-9 ساعات | sleep | cortisol -7, serotonin +6, melatonin_rhythm +7, dopamine +4 |
| sahar_late | Staying up late (sahar) | سهر لوقت متأخر | sleep | melatonin -8, cortisol +6, serotonin -5, ghrelin_hunger +5 |
| qahwa_coffee | Turkish/Arabic coffee 1-2 cups | قهوة تركي / عربي 1-2 فنجان | stimulant | dopamine +4, adrenaline +4, cortisol +3 if >2 cups; sleep_tonight -4 if after 4pm |
| shai_tea | Black tea / shai | شاي أسود | stimulant | dopamine +2, adrenaline +2 (milder than coffee) |
| shisha | Shisha session | شيشة | smoking | cortisol +6, serotonin -4, melatonin_sleep -5, energy_sex -4; tip: cessation support, no shaming |
| cigarettes | Cigarettes | سجائر | smoking | same as shisha, slightly higher adrenaline +5 |
| social_media_2h | Heavy social/scrolling 2h+ | سوشيال ميديا وتصفح +ساعتين | digital | dopamine spike then -5 (crash model: +3 now, -6 in 3h), serotonin -3, melatonin -5 if night |
| gaming_1h | Gaming 1h+ | جيمينج ساعة+ | digital | dopamine +5 short, adrenaline +5, cortisol +4 if competitive/late; daytime casual milder |
| work_stress | Hard work/exam stress event | ضغط شغل / امتحانات | stress | cortisol +8, adrenaline +6, serotonin -4, GABA -5, oxytocin -3 |
| walk_30min | Walk 30 min | مشي 30 دقيقة | sport | serotonin +7, dopamine +6, endorphins +6, cortisol -6, GABA +4 |
| gym_resistance | Gym / resistance 45 min | جيم / مقاومة 45 دقيقة | sport | endorphins +8, dopamine +7, testosterone_energy +5, cortisol -5 (overtraining flag if daily intense → cortisol +4) |
| sunlight_15min | Sunlight 15 min morning | شمس الصباح 15 دقيقة | environment | serotonin +7, melatonin_rhythm +5 (night sleep better) |
| salah_any | Prayer (any, logged as factor) | صلاة (كعامل مؤثر) | worship-factor | cortisol -6, serotonin +4, GABA +5 — same engine as food, no separate tab (owner lock) |
| fasting_day | Fasting day (Ramadan/voluntary) | صيام | worship-factor | insulin_need -6, ghrelin wave +4 midday, cortisol 0 to +3 if dehydrated; evening circadian note |

Note: 15 rows above (12 + 3 worship/sport variants merged). Engine picks top 12 shown per user frequency (config `show_most_used: 12`). Smoking/shisha/sahar worded supportively, with quit/reduce tips, never judgment.

Feelings multi-select (feel_states.json): anxious, low_energy, cant_focus, sad, irritable, craving_sugar, cant_sleep, motivated, calm, energetic — same 10, ar reviewed.

## B. 25 MENA Foods/Drinks (foods.json draft)

Portions = common serving. Deltas conservative, satiety/hunger via insulin/ghrelin/leptin cluster.

| # | id | EN | AR | Notes / deltas |
|---|----|----|----|----------------|
| 1 | qahwa_arabi | Arabic coffee (qahwa) | قهوة عربي | caffeine moderate: dopamine +3, sleep -3 if evening |
| 2 | turkish_coffee | Turkish coffee | قهوة تركي | stronger: dopamine +4, adrenaline +4 |
| 3 | shai_masry | Egyptian black tea | شاي مصري | mild stimulant +2 |
| 4 | karkadeh_cold | Cold karkadeh (hibiscus) | كركديه ساقع | calming ritual: cortisol -3, no caffeine |
| 5 | sobia | Sobia (Ramadan drink) | سوبيا | sugary: serotonin +3 short, insulin_need +5, crash -3 |
| 6 | qamar_deen | Qamar al-deen (apricot) | قمر الدين | sugary: same as sobia, vitamin A note |
| 7 | dates_3 | Dates 3 pcs | تمر 3 حبات | quick energy: serotonin +3, insulin +3; moderate note |
| 8 | koshary | Koshary (medium) | كشري (طبق وسط) | heavy carbs: serotonin +5, insulin +7, sleepiness +4; walk-after tip |
| 9 | foul_taamiya | Foul + taamiya | فول وطعمية | protein+fiber: dopamine +4, satiety +6, serotonin +3 |
| 10 | shawarma | Shawarma sandwich | شاورما | protein+fat: dopamine +4, satiety +5; sodium note |
| 11 | grilled_chicken_rice | Grilled chicken + rice | فراخ مشوية ورز | balanced: dopamine +4, serotonin +4 |
| 12 | fish_grilled | Grilled fish (boli/sea) | سمك مشوي | omega-3: serotonin +4, dopamine +3 |
| 13 | eggs_dairy | Eggs / white cheese | بيض / جبنة بيضا | tryptophan+tyrosine: serotonin +4, dopamine +4 |
| 14 | nuts_mix | Nuts handful | مكسرات (حفنة) | healthy fats: satiety +6, serotonin +3 |
| 15 | veggies_fruit | Veggies + seasonal fruit | خضار وفاكهة موسمية | fiber/polyphenols: serotonin +4, insulin steady |
| 16 | dark_chocolate | Dark chocolate 20g | شوكولاتة دارك 20ج | flavonoids: serotonin +3, endorphins +3, modesty note |
| 17 | honey_spoon | Honey spoon | عسل (معلقة) | sugar: serotonin +2 short, insulin +3 |
| 18 | soda | Soda / sugary drink | مياه غازية مسكرة | spike-crash: dopamine +3 now -5 later, insulin +8 |
| 19 | fast_food_burger | Burger + fries | برجر وبطاطس | high fat/sugar: dopamine +4 short, insulin +8, cortisol +2, energy crash |
| 20 | molokhia_rice | Molokhia + rice + rabbit/chicken | ملوخية ورز | balanced home meal: serotonin +4, satiety +5 |
| 21 | mahshi | Mahshi (mixed) | محشي | heavy: serotonin +4, insulin +6 |
| 22 | lentil_soup | Lentil soup (shorbat ads) | شوربة عدس | tryptophan+fiber: serotonin +5, satiety +6 |
| 23 | yogurt_laban | Yogurt / laban | زبادي / لبن رايب | gut-friendly: serotonin +3 (gut-brain note, modest) |
| 24 | water_2L | Water 2L through day | مياه 2 لتر | cortisol -3 (dehydration raises strain), energy +3 |
| 25 | energy_drink | Energy drink | مشروب طاقة | caffeine+sugar bomb: adrenaline +8, dopamine +4 now, cortisol +6, sleep -8; strong avoid-excess tip |

Rules: no dish shaming ("koshary is bad" FORBIDDEN). Copy pattern: "Enjoy + balance: smaller portion + walk 15 min + water". Sugar/caffeine show spike-now-crash-later dual delta (engine supports `immediate` + `delayed_3h`). All strings en+ar in i18n, portions in grams/ml config, Ramadan flag for night-heavy items.

## C. No-Doctor Guardrails (linked to 02)
- Deltas capped ±8, evidenceLevel required per row (strong/moderate/preliminary), preliminary rows show "early evidence" badge.
- No weight-loss promises, no "lowers cholesterol X%", no supplement doses.
- Smoking/alcohol: harm-reduction tips only + quit-line numbers per country (config `quit_lines.json`), no moralizing.
