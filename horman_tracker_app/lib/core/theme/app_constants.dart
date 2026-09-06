/// App-wide constants: storage keys and language options.
/// Language names stay native on purpose (English/العربية are proper names,
/// never translated). User-facing sentences live in arb files, never here.
abstract final class AppConstants {
  static const String guestBoxName = 'horman_guest';
  static const String todayLogKeyPrefix = 'todayLog_';
  static const String tipFeedbackKey = 'tipFeedback';
  static const String profileKey = 'profile';

  static const List<String> languageCodes = ['en', 'ar'];
  static const List<String> languageNativeNames = ['English', 'العربية'];
}
