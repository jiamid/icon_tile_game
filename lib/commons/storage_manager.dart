import 'package:shared_preferences/shared_preferences.dart';

class KeyType<T> {
  String key = '';
  T defaultValue;
  late Type type;

  KeyType(this.key, this.defaultValue) {
    if (T == String || T == int || T == double || T == bool) {
      type = T;
    } else {
      throw ArgumentError('Invalid type for KeyType');
    }
  }
}

class StorageKey {
  static KeyType language = KeyType<String>('KEY_LANGUAGE', 'en'); // 语言
  static KeyType gold = KeyType<int>('KEY_GOLD', 0); // 金币
}

/// 全局设置
class StorageManager {
  final _sp = SharedPreferences.getInstance();

  static final StorageManager _ = StorageManager._internal();

  StorageManager._internal();

  factory StorageManager() {
    return _;
  }

  setValue(KeyType keyType, dynamic value) async {
    if (value.runtimeType != keyType.type) {
      throw ArgumentError('Invalid value type to set ${keyType.key}');
    }
    switch (keyType.type) {
      case String:
        await _sp.then((sp) => sp.setString(keyType.key, value));
        break;
      case int:
        await _sp.then((sp) => sp.setInt(keyType.key, value));
        break;
      case bool:
        await _sp.then((sp) => sp.setBool(keyType.key, value));
        break;
      case double:
        await _sp.then((sp) => sp.setDouble(keyType.key, value));
        break;
      default:
        throw ArgumentError('Invalid type for KeyType');
    }
  }

  Future<T> getValue<T>(KeyType keyType) async {
    dynamic spValue;
    switch (keyType.type) {
      case String:
        spValue = await _sp.then((sp) => sp.getString(keyType.key));
        break;
      case int:
        spValue = await _sp.then((sp) => sp.getInt(keyType.key));
        break;
      case bool:
        spValue = await _sp.then((sp) => sp.getBool(keyType.key));
        break;
      case double:
        spValue = await _sp.then((sp) => sp.getDouble(keyType.key));
        break;
      default:
        throw ArgumentError('Invalid type for KeyType');
    }
    return spValue ?? keyType.defaultValue;
  }
}
