// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tileZoo => 'Tile Zoo';

  @override
  String get playGame => 'PLAY';

  @override
  String level(num levelNum) {
    return 'level $levelNum';
  }

  @override
  String get gameFailMsg => 'You Lose';

  @override
  String get home => 'Home';

  @override
  String get restart => 'Restart';

  @override
  String get gameSuccessMsg => 'Super Win';

  @override
  String get replay => 'Replay';

  @override
  String get language => 'Language';

  @override
  String get langCode => 'en';
}
