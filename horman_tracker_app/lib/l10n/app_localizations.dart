import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'Hormon Tracker'**
  String get app_title;

  /// No description provided for @action_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get action_continue;

  /// No description provided for @action_continue_as_guest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get action_continue_as_guest;

  /// No description provided for @action_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get action_back;

  /// No description provided for @action_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get action_save;

  /// No description provided for @action_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get action_skip;

  /// No description provided for @action_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get action_retry;

  /// No description provided for @action_got_it.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get action_got_it;

  /// No description provided for @balance_low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get balance_low;

  /// No description provided for @balance_balanced.
  ///
  /// In en, this message translates to:
  /// **'Balanced'**
  String get balance_balanced;

  /// No description provided for @balance_high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get balance_high;

  /// No description provided for @confidence_low.
  ///
  /// In en, this message translates to:
  /// **'Low confidence'**
  String get confidence_low;

  /// No description provided for @confidence_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium confidence'**
  String get confidence_medium;

  /// No description provided for @confidence_high.
  ///
  /// In en, this message translates to:
  /// **'High confidence'**
  String get confidence_high;

  /// No description provided for @onboarding_title.
  ///
  /// In en, this message translates to:
  /// **'Understand your hormones simply'**
  String get onboarding_title;

  /// No description provided for @onboarding_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We estimate daily trends from your habits — not lab values.'**
  String get onboarding_subtitle;

  /// No description provided for @disclaimer_estimate_only.
  ///
  /// In en, this message translates to:
  /// **'Estimates only — not a lab test. See a doctor for persistent symptoms.'**
  String get disclaimer_estimate_only;

  /// No description provided for @home_today_title.
  ///
  /// In en, this message translates to:
  /// **'Today\'s estimate'**
  String get home_today_title;

  /// No description provided for @home_log_day.
  ///
  /// In en, this message translates to:
  /// **'Log my day'**
  String get home_log_day;

  /// No description provided for @home_rebalance.
  ///
  /// In en, this message translates to:
  /// **'How to rebalance?'**
  String get home_rebalance;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Guest first — login is optional, anytime.'**
  String get login_subtitle;

  /// No description provided for @login_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get login_apple;

  /// No description provided for @login_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get login_google;

  /// No description provided for @login_email.
  ///
  /// In en, this message translates to:
  /// **'Continue with Email'**
  String get login_email;

  /// No description provided for @login_backend_pending.
  ///
  /// In en, this message translates to:
  /// **'Online login activates after server setup — continue as guest for now.'**
  String get login_backend_pending;

  /// No description provided for @settings_title.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_guest_mode.
  ///
  /// In en, this message translates to:
  /// **'Guest mode — your data stays on this device.'**
  String get settings_guest_mode;

  /// No description provided for @settings_version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get settings_version;

  /// No description provided for @hormone_dopamine.
  ///
  /// In en, this message translates to:
  /// **'Dopamine'**
  String get hormone_dopamine;

  /// No description provided for @hormone_serotonin.
  ///
  /// In en, this message translates to:
  /// **'Serotonin'**
  String get hormone_serotonin;

  /// No description provided for @hormone_oxytocin.
  ///
  /// In en, this message translates to:
  /// **'Oxytocin'**
  String get hormone_oxytocin;

  /// No description provided for @hormone_endorphins.
  ///
  /// In en, this message translates to:
  /// **'Endorphins'**
  String get hormone_endorphins;

  /// No description provided for @hormone_cortisol.
  ///
  /// In en, this message translates to:
  /// **'Cortisol'**
  String get hormone_cortisol;

  /// No description provided for @hormone_melatonin.
  ///
  /// In en, this message translates to:
  /// **'Melatonin'**
  String get hormone_melatonin;

  /// No description provided for @hormone_energy_sex.
  ///
  /// In en, this message translates to:
  /// **'Energy balance'**
  String get hormone_energy_sex;

  /// No description provided for @hormone_appetite.
  ///
  /// In en, this message translates to:
  /// **'Appetite balance'**
  String get hormone_appetite;

  /// No description provided for @hormone_adrenaline.
  ///
  /// In en, this message translates to:
  /// **'Adrenaline'**
  String get hormone_adrenaline;

  /// No description provided for @hormone_gaba.
  ///
  /// In en, this message translates to:
  /// **'Calm (GABA)'**
  String get hormone_gaba;

  /// No description provided for @checkin_title.
  ///
  /// In en, this message translates to:
  /// **'Log my day'**
  String get checkin_title;

  /// No description provided for @checkin_step_feel.
  ///
  /// In en, this message translates to:
  /// **'How do you feel today?'**
  String get checkin_step_feel;

  /// No description provided for @checkin_step_do.
  ///
  /// In en, this message translates to:
  /// **'What did you do?'**
  String get checkin_step_do;

  /// No description provided for @checkin_step_eat.
  ///
  /// In en, this message translates to:
  /// **'What did you eat and drink?'**
  String get checkin_step_eat;

  /// No description provided for @action_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get action_next;

  /// No description provided for @action_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get action_done;

  /// No description provided for @home_empty_hint.
  ///
  /// In en, this message translates to:
  /// **'Log your day to see your hormone estimate.'**
  String get home_empty_hint;

  /// No description provided for @home_why_title.
  ///
  /// In en, this message translates to:
  /// **'Why?'**
  String get home_why_title;

  /// No description provided for @feeling_anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get feeling_anxious;

  /// No description provided for @feeling_low_energy.
  ///
  /// In en, this message translates to:
  /// **'Low energy'**
  String get feeling_low_energy;

  /// No description provided for @feeling_cant_focus.
  ///
  /// In en, this message translates to:
  /// **'Can\'t focus'**
  String get feeling_cant_focus;

  /// No description provided for @feeling_sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get feeling_sad;

  /// No description provided for @feeling_irritable.
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get feeling_irritable;

  /// No description provided for @feeling_craving_sugar.
  ///
  /// In en, this message translates to:
  /// **'Craving sugar'**
  String get feeling_craving_sugar;

  /// No description provided for @feeling_cant_sleep.
  ///
  /// In en, this message translates to:
  /// **'Can\'t sleep'**
  String get feeling_cant_sleep;

  /// No description provided for @feeling_motivated.
  ///
  /// In en, this message translates to:
  /// **'Motivated'**
  String get feeling_motivated;

  /// No description provided for @feeling_calm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get feeling_calm;

  /// No description provided for @feeling_energetic.
  ///
  /// In en, this message translates to:
  /// **'Energetic'**
  String get feeling_energetic;

  /// No description provided for @act_sleep_good.
  ///
  /// In en, this message translates to:
  /// **'Good sleep 7-9h'**
  String get act_sleep_good;

  /// No description provided for @act_sleep_short.
  ///
  /// In en, this message translates to:
  /// **'Short sleep'**
  String get act_sleep_short;

  /// No description provided for @act_sahar_late.
  ///
  /// In en, this message translates to:
  /// **'Late sahar'**
  String get act_sahar_late;

  /// No description provided for @act_walk_30min.
  ///
  /// In en, this message translates to:
  /// **'Walk 30 min'**
  String get act_walk_30min;

  /// No description provided for @act_gym_resistance.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get act_gym_resistance;

  /// No description provided for @act_sunlight_15min.
  ///
  /// In en, this message translates to:
  /// **'Morning sun'**
  String get act_sunlight_15min;

  /// No description provided for @act_qahwa_coffee.
  ///
  /// In en, this message translates to:
  /// **'Coffee'**
  String get act_qahwa_coffee;

  /// No description provided for @act_shai_tea.
  ///
  /// In en, this message translates to:
  /// **'Tea'**
  String get act_shai_tea;

  /// No description provided for @act_shisha.
  ///
  /// In en, this message translates to:
  /// **'Shisha'**
  String get act_shisha;

  /// No description provided for @act_cigarettes.
  ///
  /// In en, this message translates to:
  /// **'Cigarettes'**
  String get act_cigarettes;

  /// No description provided for @act_social_media_2h.
  ///
  /// In en, this message translates to:
  /// **'Heavy scrolling'**
  String get act_social_media_2h;

  /// No description provided for @act_gaming_1h.
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get act_gaming_1h;

  /// No description provided for @act_work_stress.
  ///
  /// In en, this message translates to:
  /// **'Work stress'**
  String get act_work_stress;

  /// No description provided for @act_salah_any.
  ///
  /// In en, this message translates to:
  /// **'Prayer'**
  String get act_salah_any;

  /// No description provided for @act_fasting_day.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get act_fasting_day;

  /// No description provided for @food_qahwa_arabi.
  ///
  /// In en, this message translates to:
  /// **'Arabic coffee'**
  String get food_qahwa_arabi;

  /// No description provided for @food_turkish_coffee.
  ///
  /// In en, this message translates to:
  /// **'Turkish coffee'**
  String get food_turkish_coffee;

  /// No description provided for @food_shai_masry.
  ///
  /// In en, this message translates to:
  /// **'Egyptian tea'**
  String get food_shai_masry;

  /// No description provided for @food_karkadeh_cold.
  ///
  /// In en, this message translates to:
  /// **'Cold hibiscus'**
  String get food_karkadeh_cold;

  /// No description provided for @food_sobia.
  ///
  /// In en, this message translates to:
  /// **'Sobia'**
  String get food_sobia;

  /// No description provided for @food_qamar_deen.
  ///
  /// In en, this message translates to:
  /// **'Apricot drink'**
  String get food_qamar_deen;

  /// No description provided for @food_dates_3.
  ///
  /// In en, this message translates to:
  /// **'3 dates'**
  String get food_dates_3;

  /// No description provided for @food_koshary.
  ///
  /// In en, this message translates to:
  /// **'Koshary'**
  String get food_koshary;

  /// No description provided for @food_foul_taamiya.
  ///
  /// In en, this message translates to:
  /// **'Foul and falafel'**
  String get food_foul_taamiya;

  /// No description provided for @food_shawarma.
  ///
  /// In en, this message translates to:
  /// **'Shawarma'**
  String get food_shawarma;

  /// No description provided for @food_grilled_chicken_rice.
  ///
  /// In en, this message translates to:
  /// **'Grilled chicken and rice'**
  String get food_grilled_chicken_rice;

  /// No description provided for @food_fish_grilled.
  ///
  /// In en, this message translates to:
  /// **'Grilled fish'**
  String get food_fish_grilled;

  /// No description provided for @food_eggs_dairy.
  ///
  /// In en, this message translates to:
  /// **'Eggs and dairy'**
  String get food_eggs_dairy;

  /// No description provided for @food_nuts_mix.
  ///
  /// In en, this message translates to:
  /// **'Nuts'**
  String get food_nuts_mix;

  /// No description provided for @food_veggies_fruit.
  ///
  /// In en, this message translates to:
  /// **'Veggies and fruit'**
  String get food_veggies_fruit;

  /// No description provided for @food_dark_chocolate.
  ///
  /// In en, this message translates to:
  /// **'Dark chocolate'**
  String get food_dark_chocolate;

  /// No description provided for @food_honey_spoon.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get food_honey_spoon;

  /// No description provided for @food_soda.
  ///
  /// In en, this message translates to:
  /// **'Soda'**
  String get food_soda;

  /// No description provided for @food_fast_food_burger.
  ///
  /// In en, this message translates to:
  /// **'Burger and fries'**
  String get food_fast_food_burger;

  /// No description provided for @food_molokhia_rice.
  ///
  /// In en, this message translates to:
  /// **'Molokhia and rice'**
  String get food_molokhia_rice;

  /// No description provided for @food_mahshi.
  ///
  /// In en, this message translates to:
  /// **'Mahshi'**
  String get food_mahshi;

  /// No description provided for @food_lentil_soup.
  ///
  /// In en, this message translates to:
  /// **'Lentil soup'**
  String get food_lentil_soup;

  /// No description provided for @food_yogurt_laban.
  ///
  /// In en, this message translates to:
  /// **'Yogurt'**
  String get food_yogurt_laban;

  /// No description provided for @food_water_2L.
  ///
  /// In en, this message translates to:
  /// **'Water 2L'**
  String get food_water_2L;

  /// No description provided for @food_energy_drink.
  ///
  /// In en, this message translates to:
  /// **'Energy drink'**
  String get food_energy_drink;

  /// No description provided for @evidence_strong.
  ///
  /// In en, this message translates to:
  /// **'Strong evidence'**
  String get evidence_strong;

  /// No description provided for @evidence_moderate.
  ///
  /// In en, this message translates to:
  /// **'Growing evidence'**
  String get evidence_moderate;

  /// No description provided for @evidence_preliminary.
  ///
  /// In en, this message translates to:
  /// **'Early evidence'**
  String get evidence_preliminary;

  /// No description provided for @tip_section_do.
  ///
  /// In en, this message translates to:
  /// **'Do'**
  String get tip_section_do;

  /// No description provided for @tip_section_eat.
  ///
  /// In en, this message translates to:
  /// **'Eat and drink'**
  String get tip_section_eat;

  /// No description provided for @tip_section_avoid.
  ///
  /// In en, this message translates to:
  /// **'Avoid'**
  String get tip_section_avoid;

  /// No description provided for @tip_section_islamic.
  ///
  /// In en, this message translates to:
  /// **'Gentle habits'**
  String get tip_section_islamic;

  /// No description provided for @library_title.
  ///
  /// In en, this message translates to:
  /// **'How do you feel?'**
  String get library_title;

  /// No description provided for @library_demo_note.
  ///
  /// In en, this message translates to:
  /// **'Typical example — not your diagnosis.'**
  String get library_demo_note;

  /// No description provided for @library_top_actions.
  ///
  /// In en, this message translates to:
  /// **'What helps'**
  String get library_top_actions;

  /// No description provided for @pattern_anxious.
  ///
  /// In en, this message translates to:
  /// **'Anxious'**
  String get pattern_anxious;

  /// No description provided for @pattern_cant_sleep.
  ///
  /// In en, this message translates to:
  /// **'Can\'t sleep'**
  String get pattern_cant_sleep;

  /// No description provided for @pattern_low_energy.
  ///
  /// In en, this message translates to:
  /// **'Low energy'**
  String get pattern_low_energy;

  /// No description provided for @pattern_post_workout_glow.
  ///
  /// In en, this message translates to:
  /// **'Post-workout glow'**
  String get pattern_post_workout_glow;

  /// No description provided for @pattern_lonely_weekend.
  ///
  /// In en, this message translates to:
  /// **'Lonely weekend'**
  String get pattern_lonely_weekend;

  /// No description provided for @pattern_exam_panic.
  ///
  /// In en, this message translates to:
  /// **'Exam panic'**
  String get pattern_exam_panic;

  /// No description provided for @support_title.
  ///
  /// In en, this message translates to:
  /// **'Need help now?'**
  String get support_title;

  /// No description provided for @support_body.
  ///
  /// In en, this message translates to:
  /// **'If you feel unsafe or have worrying symptoms, contact a doctor or your local helpline.'**
  String get support_body;

  /// No description provided for @health_sync.
  ///
  /// In en, this message translates to:
  /// **'Sync health'**
  String get health_sync;

  /// No description provided for @health_why_title.
  ///
  /// In en, this message translates to:
  /// **'Why connect?'**
  String get health_why_title;

  /// No description provided for @health_why_body.
  ///
  /// In en, this message translates to:
  /// **'Sleep, steps and workouts tune your estimate. Health data never leaves this device.'**
  String get health_why_body;

  /// No description provided for @health_allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get health_allow;

  /// No description provided for @health_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get health_skip;

  /// No description provided for @health_unavailable.
  ///
  /// In en, this message translates to:
  /// **'Health data unavailable on this device.'**
  String get health_unavailable;

  /// No description provided for @health_denied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied — manual logging still works fully.'**
  String get health_denied;

  /// No description provided for @health_synced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get health_synced;

  /// No description provided for @methods_title.
  ///
  /// In en, this message translates to:
  /// **'How estimates work'**
  String get methods_title;

  /// No description provided for @methods_p1.
  ///
  /// In en, this message translates to:
  /// **'Scores are 0-100 balance trends, not lab values. Only a blood test measures hormones.'**
  String get methods_p1;

  /// No description provided for @methods_p2.
  ///
  /// In en, this message translates to:
  /// **'Every habit starts from 50 and moves a few points, based on published lifestyle research.'**
  String get methods_p2;

  /// No description provided for @methods_p3.
  ///
  /// In en, this message translates to:
  /// **'Health data (sleep, steps, workouts) is summarized on your device and never uploaded.'**
  String get methods_p3;

  /// No description provided for @methods_p4.
  ///
  /// In en, this message translates to:
  /// **'If low mood, fatigue or cycle changes last over 2 weeks, see a doctor.'**
  String get methods_p4;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
