import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/index.dart';
import '../pages/game_over.dart';

class Pages {
  static const home = HomePage;
  static const index = IndexPage;
  static const gameOver = GameOverPage;
}

/// 构造方法
Map<Type, Function> globalPageMap = {
  IndexPage: (context, {arguments}) => const IndexPage(),
  HomePage: (context, {arguments}) => const HomePage(),
  GameOverPage: (context, {arguments}) => GameOverPage(
        gameStatus: arguments['gameStatus'] == true,
      )
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
            pageBuilder: (_, __, ___) => view(_, arguments: arguments),
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
