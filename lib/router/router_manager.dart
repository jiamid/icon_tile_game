import 'package:flutter/material.dart';

import '../pages/index.dart';

class Pages {
  static const index = IndexPage;
}

/// 构造方法
Map<Type, Function> globalPageMap = {
  IndexPage: (context, {arguments}) => const IndexPage(),
};

/// 页面控制器
class GlobalPageRouter {
  static Map<Type, Function> pageMap = globalPageMap;

  static void go(Type? key, BuildContext context, {arguments}) {
    if (pageMap[key] != null) {
      var view = pageMap[key]!;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => view(context, arguments: arguments),
      ));
    }
  }

  static void replace(Type? key, BuildContext context, {arguments}) {
    if (pageMap[key] != null) {
      var view = pageMap[key]!;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => view(_),
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation1,
                Animation<double> animation2,
                Widget child) {
              return FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animation1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            }),
      );
    }
  }

  static void back(BuildContext context) {
    Navigator.of(context).pop();
  }
}
