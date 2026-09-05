# 13 - Auth and Guest Mode (Login Optional, Guest-First)

Owner lock (2026-09-05): login OPTIONAL + Supabase Auth + phone OTP V1-only (MVP = anonymous guest + Apple + Google).

## 1. Principle
- No login wall. User can install → onboard → check-in → see bars → get tips WITHOUT any account.
- Login exists only for: backup, multi-device, long history, doctor PDF across devices, future community/premium.
- Never block core medical-education value behind auth. Never force phone number. Never sell data.
- Auth copy ar/en from i18n, providers from config (`auth_providers.json`), flippable OTA per country.

## 2. What Works WITHOUT Login (Guest, Offline-First)
- Full estimator: check-in (feel/do/eat incl. salah/fasting as factors), 7+hunger/stress bars, unified `HormoneBalanceChart`, rebalance tips, feel-state library.
- Health sync (HealthKit / Health Connect) — works locally, no account needed. Permission is health-permission, separate from login.
- History on THIS device (Hive, e.g. last 90 days MVP, configurable), streaks, theme/lang, Islamic-factor toggles.
- Guest identity: local `guestId = UUIDv4` + anonymous key in secure storage. All rows carry `ownerId = guestId`. No PII.
- Safety: disclaimers, red-flag cards, age gate all work offline.

## 3. What Login ADDS (Value, Not Punishment)
- Cloud backup + restore (encrypted), multi-device sync (iPhone + Android tablet).
- Unlimited history + correlations ("when you walk + Fajr routine, calm +18%") computed server-side V1+.
- Doctor PDF with verified account + longitudinal export.
- Future: premium, family challenges, anonymized research opt-in (explicit, IRB).
- UX must SAY this: "Log in to back up your progress — optional" with Skip. Show benefit list, never fear ("you will lose everything!").

## 4. Providers (Flutter, MENA-Friendly, Config-Driven)
Default MVP: Anonymous (built-in guest) + Sign in with Apple + Sign in with Google + Email magic-link (all $0).
Phone OTP: DISABLED until revenue covers it (`phone_otp.enabled:false`). Reason (2026-09-05 cost review): Egypt SMS is ~$0.14-0.40/msg (Twilio EG $0.3959/segment; aggregators ~$0.135) vs KSA ~$0.056-0.116 — 1,000 logins ≈ $135-400. Firebase phone bills per SMS (first 10/day free only). Unifonic platform starts ~$499/mo + per-SMS. So quasi-free = zero-SMS auth.
If phone ever enabled later: prefer Unifonic (MENA sender IDs, Arabic, NTRA/CITC compliance) over Twilio for EG/SA deliverability; sender name e.g. `HormanApp` (Latin, 11 chars max, pre-register with carriers; Arabic sender IDs unreliable for OTP). WhatsApp OTP as second choice (Twilio Verify / Unifonic Authenticate) — cheaper than SMS in EG and better delivery, still paid per conversation.
- iOS rule: if you offer Google/phone/email social login, Apple REQUIRES Sign in with Apple — include from day 1.
- `auth_providers.json`: `[{id:"apple",enabled:true,minAppVersion:"1.0"},{id:"google",enabled:true},{id:"phone_otp",enabled:false,countries:["EG","SA"]},{id:"email",enabled:true}]` — no provider name hardcoded in UI.
- Backend choice (ask owner, default proposal): **Supabase Auth** — native anonymous sign-in + `linkIdentity` upgrade (guest→permanent, zero data loss), Postgres RLS per `auth.uid()`, magic-link + phone via Twilio/Unifonic. Alternative **Firebase Auth** — easier phone OTP + Crashlytics, but Firestore rules + migration more work. Both support PKCE OAuth, JWT rotation. Decision in Q2-update below; engine stays backend-agnostic via `AuthRepo` interface.

## 5. Guest → Account Upgrade (Zero Data Loss, Critical Flow)
1. Guest uses app for days (local Hive: profile, inputs, estimates, tip likes).
2. Taps "Back up / Log in" → picks provider → OAuth/OTP → backend returns `userId`.
3. App calls `linkGuest(guestId → userId)`: upload local snapshot with `deviceId + lastModified`, server merges (server timestamp wins on conflict, local never deleted before ack).
4. On success: `ownerId` rewrites to `userId` locally, guest keys tombstoned, banner "Progress backed up ✓". On fail/offline: stay guest, queue sync job, retry silently.
5. Downgrade: logout → choice "Keep on this device as guest" or "Erase". Delete account → Apple-mandated in-settings button → soft-delete 30d grace → hard wipe + RLS revoke (see §7).

## 6. Sessions, Tokens, Device Security
- JWT access (short, ~1h) + rotating refresh (30d) in `flutter_secure_storage` (Keychain/Keystore), never SharedPrefs/logs.
- Biometric app lock (FaceID/fingerprint) OPTIONAL, per-device, off by default; PIN fallback. Does NOT replace login.
- Offline: refresh fails → stay in cached session, read/write local, sync later. Show "Offline — changes saved on device".
- Rate limits: OTP 5 tries / 10 min + cooldown copy ar/en; OAuth uses PKCE + state; no secrets in client.
- Flavors: dev/staging/prod separate OAuth client IDs + redirect URIs via `--dart-define`, never committed.

## 7. Privacy, Compliance, Medical Sensitivity
- Health data = sensitive. Sync only `estimates + inputs`, raw HR/HRV aggregates only if user opts "detailed backup". No health in analytics/crash logs (scrub).
- Consents: separate toggles — (a) account/backup, (b) health sync (local-only, see file 09 lock), (c) analytics, (d) research. Each with ar/en explanation + revoke anytime. Health toggle NEVER enables upload (`health_upload:false` enforced in code + RLS deny).
- Rights: export (JSON+PDF), delete device data, delete cloud account (30d undo), data residency default EU + option ME region (to confirm with owner/lawyer).
- Kids <13: guest only, no account, no cloud, guardian notice. Teens 13-16: account needs guardian consent flag per country (config).
- Stores: Apple privacy nutrition labels + Data Safety form filled from this file; account-deletion URL in store listing.

## 8. UX Spec (RTL-Safe, No Hardcode)
- Onboarding step 4: card "Continue as Guest →" primary, "Log in / Back up" secondary. Skip always visible. No dark pattern.
- Settings → Account section states: `Guest • Only on this device` vs `Backed up • user@email` with actions: Log in, Switch, Export, Delete.
- Login sheet: provider buttons from config (icon+label via i18n `auth_provider_apple` etc.), loading shimmer, error mapping (`wrong-otp`, `network`, `cancelled`) to friendly ar/en, no stack traces.
- Post-login: single celebratory check "Backed up", NOT confetti-spam. Post-logout: explicit choice sheet (keep/erase).

## 9. Testing & Kill-Switches
- Unit: merge logic (guest→user, conflict, offline queue). Widget: ar/en login sheet goldens, RTL button order. Integration: fresh install→guest check-in<60s→login→reinstall→restore.
- Flags: `auth_enabled`, `phone_otp_enabled`, `backup_enabled`, `delete_account_enabled` — any can be disabled OTA without release.
- Metrics: guest%, upgrade%, restore success, OTP success/failure, deletion requests. No funnel shaming.

## 10. Owner Decisions Still Needed (No Assumption)
- Backend: Supabase (recommended for anonymous-upgrade + RLS) vs Firebase (easier OTP)? See Q2-add.
- Phone OTP in MVP or V1? Which SMS provider (Unifonic/Twilio/Firebase) + sender name ar?
- Data region + retention (90d local / unlimited cloud?) + kids age gate 13 vs 16?
