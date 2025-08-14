// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get tileZoo => 'Tile Zoo';

  @override
  String get playGame => '开始游戏';

  @override
  String level(num levelNum) {
    return '第$levelNum关';
  }

  @override
  String get gameFailMsg => '失败是常有的事情';

  @override
  String get home => '返回大厅';

  @override
  String get restart => '重新开始';

  @override
  String get gameSuccessMsg => '你通过了最终的考验！！！';

  @override
  String get replay => '再来一次';

  @override
  String get language => '语言';

  @override
  String get langCode => 'zh';
}
