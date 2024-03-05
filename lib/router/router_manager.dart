import 'package:flutter/material.dart';

import '../pages/home.dart';
import '../pages/game_room.dart';
import '../pages/game_over.dart';
import '../custom_widget/loading_page.dart';
import '../pages/shop_page.dart';
import '../pages/transaction_records_page.dart';

class Pages {
  static const home = HomePage;
  static const gameRoom = GameRoomPage;
  static const gameOver = GameOverPage;
  static const fakeLoadingPage = FakeLoadingPage;
  static const shopPage = ShopPage;
  static const transactionRecordsPage = TransactionRecordsPage;
}

/// 构造方法
Map<Type, Function> globalPageMap = {
  GameRoomPage: (context, {arguments}) => const GameRoomPage(),
  TransactionRecordsPage: (context, {arguments}) =>
      const TransactionRecordsPage(),
  ShopPage: (context, {arguments}) => const ShopPage(),
  HomePage: (context, {arguments}) => const HomePage(),
  GameOverPage: (context, {arguments}) => GameOverPage(
        gameStatus: arguments['gameStatus'] == true,
      ),
  FakeLoadingPage: (context, {arguments}) => FakeLoadingPage(
        duration: arguments['duration'],
        nextPage: arguments['nextPage'],
        args: arguments['args'],
      )
};

/// 页面控制器
class GlobalPageRouter {
  static Map<Type, Function> pageMap = globalPageMap;

  static void go(Type? key, BuildContext context, {arguments}) {
    if (pageMap[key] != null) {
      var view = pageMap[key]!;
      Navigator.of(context).push(
        //     MaterialPageRoute(
        //   builder: (context) => view(context, arguments: arguments),
        // )
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

  static void loading(Type? key, BuildContext context, {arguments}) {
    if (pageMap[key] != null) {
      var view = pageMap[key]!;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => view(context, arguments: arguments),
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
