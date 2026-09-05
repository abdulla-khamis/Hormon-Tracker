# 15 - Costs, Free Plan and Launch (Owner: Free First Month, Then Decide by Cost)

## Owner Decision (2026-09-05)
- Launch FREE. First month free for everyone. After that decide based on real costs — may stay free if costs allow.
- Health sync: ON-DEVICE ONLY for now (no health upload even if logged in). This kills the biggest cost + privacy risk.

## Real Cost Breakdown (Flutter + Supabase, on-device health)

| Item | Cost | Notes |
|------|------|-------|
| Apple Developer Program | $99/year (mandatory for iOS release) | No way around. |
| Google Play Console | $25 one-time | No way around. |
| Supabase free tier | $0 | 500MB DB + 1GB storage + 50k monthly active users + 2M edge calls. Enough for MVP backup of inputs/estimates (tiny JSON). Auth (Apple/Google) free. |
| Supabase Pro (only if scale) | $25/mo per project | Only if >free limits or need daily backups/PITR. Start free, upgrade when metrics say so. |
| SMS OTP (phone login V1) | $0 in MVP AND V1 (disabled per 2026-09-05 cost lock — quasi-free plan) | If ever enabled: EG ~$0.135-0.40/SMS, KSA ~$0.056-0.116/SMS; 10k logins ≈ $500-4,000/mo. Unifonic platform from ~$499/mo. Firebase phone = per-SMS billing, 10/day free only. Verdict: email magic-link + Apple/Google = $0, keep phone OFF until revenue. |
| Domain + landing (optional) | $10-15/year | For account-deletion URL + privacy page (store requirement). |
| CI (GitHub Actions + Codemagic free tier) | $0 | Enough for MVP. |
| 3D/Rive assets | $0 (in-house/low-poly) | Avoid paid packs. |
| Total MVP year-1 if free-tier holds | ~$124 + domain ≈ $135 | i.e. stores + domain only. |

Why on-device health saves money: sleep/HR/HRV samples are HIGH-frequency (thousands of rows/user). Uploading them = DB + bandwidth explosion. Keeping them local (Hive) + uploading only daily estimates (7-12 numbers/day) keeps Supabase free-tier viable to ~10-20k users.

## What Could Force Paid Later
- >50k MAU or >500MB (history explosion) → Supabase $25/mo → introduce freemium THEN, not now.
- Phone OTP volume, Apple Watch sync servers, AI correlations server-side.
- Rule: never charge to unlock core bars/tips (trust). Charge only for: unlimited cloud history, multi-device advanced insights, doctor PDF pro, premium 3D/mascots.

## Recommended Launch Plan (Free, EG First)
1. MVP free, no paywall code (but keep `billing_enabled:false` flag + `plan: free_all` in Remote Config so freemium can turn on OTA without release).
2. Launch countries: Egypt ONLY first (owner cost lock 2026-09-05) — one dialect QA, one support load, free-tier lasts 3-5x longer, single store review cycle. Then SA/UAE (Arabic coffee + qahwa dallah wording check). Store listings ar/en from day 1. Prices: free, no IAP in MVP → avoids billing review delay.
3. After month 1: read Supabase usage dashboard (DB size, MAU, bandwidth). If <70% free → stay free + announce "free forever core". If >80% → propose freemium: core free, backup-pro $0.99/mo or $9.99/yr (MENA price).
4. NEVER: supplement ads, data selling, paywalled safety/red-flag content.

## Config Flags (no hardcode)
`billing.json`: `{billing_enabled:false, trial_days:30, pro_features:[], prices:{} }` + `limits.json`: `{guest_history_days:90, cloud_history_days:365, estimate_upload:true, health_upload:false}`.
