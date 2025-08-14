import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../custom_widget/loading_box.dart';
import '../router/router_manager.dart';
import 'background_box.dart';
import 'key_zoo_board.dart';
import '../l10n/app_localizations.dart';



class FakeLoadingPage extends StatefulWidget {
  const FakeLoadingPage(
      {super.key,
      required this.duration,
      required this.nextPage,
      this.args = const {}});

  final Duration duration;
  final Type nextPage;
  final dynamic args;

  @override
  FakeLoadingPageState createState() => FakeLoadingPageState();
}

class FakeLoadingPageState extends State<FakeLoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // 动画 controller
  late Animation<double> _animation; // 动画
  double nowRate = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addListener(() {
      // t 动态变化的值
      var t = _animation.value;
      if (mounted) {
        setState(() {
          nowRate = t;
        });
      }
      if (t >= 1) {
        GlobalPageRouter.replace(widget.nextPage, context,
            arguments: widget.args);
      }
    });
    // 显示小圆点的时候动画就开始
    _controller.forward();
  }

  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundBox(
        image: const AssetImage('assets/image/bg.webp'),
        child: SafeArea(
            child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    child: KeyZooBoard(
                      data: AppLocalizations.of(context)!.tileZoo,
                      fontSize: 64,
                    ),
                  ),
                  Container(
                    height: 120,
                    alignment: Alignment.center,
                    child: LoadingBox(
                      nowRate: nowRate,
                      width: 300,
                      height: 40,
                    ),
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
