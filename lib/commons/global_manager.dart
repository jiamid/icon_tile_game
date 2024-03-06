import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 全局设置
class GlobalManager {
  static final GlobalManager _ = GlobalManager._internal();

  GlobalManager._internal();

  factory GlobalManager() {
    return _;
  }

  PackageInfo? _packageInfo;

  initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  Future<PackageInfo> get packageInfo async {
    if (_packageInfo != null) return _packageInfo!;
    await initPackageInfo();
    return _packageInfo!;
  }

  GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  get context => globalKey.currentContext;
}
