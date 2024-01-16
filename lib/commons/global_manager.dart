import 'package:flutter/material.dart';

/// 全局设置
class GlobalManager {
  static final GlobalManager _ = GlobalManager._internal();

  GlobalManager._internal();

  factory GlobalManager() {
    return _;
  }

  GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  get context => globalKey.currentContext;
}
