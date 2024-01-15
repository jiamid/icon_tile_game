import 'package:shared_preferences/shared_preferences.dart';

/// 全局设置
class StorageManager {
  static const KEY_LANGUAGE = 'KEY_LANGUAGE'; // 语言
  static const KEY_REGION = 'KEY_REGION'; // 地区
  static const KEY_LAST_COPY = 'KEY_LAST_COPY'; // 上次复制

  final _sp = SharedPreferences.getInstance();

  static final StorageManager _ = StorageManager._internal();

  StorageManager._internal();

  factory StorageManager() {
    return _;
  }

  setString(String key, String value) async {
    await _sp.then((sp) => sp.setString(key, value));
  }

  Future<String> getString(String key, {String defValue = ''}) async {
    return await _sp.then((sp) {
      var value = sp.getString(key);
      if (value != null) {
        return value;
      } else {
        return defValue;
      }
    });
  }
}