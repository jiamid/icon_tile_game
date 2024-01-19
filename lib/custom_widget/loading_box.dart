import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingBox extends StatelessWidget {
  const LoadingBox(
      {super.key, required this.nowRate, required this.width, this.height})
      : assert(0 <= nowRate && nowRate <= 1);

  final double nowRate;
  final double? height;
  final double width;

  @override
  Widget build(BuildContext context) {
    var trueHeight = height ?? 60;
    var halfHeight = trueHeight * 0.5;
    var offsetHeight = halfHeight * 0.5;

    var loadingBarWidth = width - trueHeight;
    var nowBarWidth = loadingBarWidth * nowRate;

    return Stack(
      children: [
        SizedBox(
          width: width,
          height: trueHeight,
        ),
        Positioned(
          top: offsetHeight,
          left: halfHeight,
          child: Container(
            width: loadingBarWidth,
            height: halfHeight,
            decoration: BoxDecoration(
              color: const Color(0xFFFCE0B7),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: const Color(0xFFFF871f), // 边框颜色
                width: 1, // 边框宽度
              ),
            ),
          ),
        ),
        Positioned(
          top: offsetHeight,
          left: halfHeight,
          child: Container(
            height: halfHeight,
            alignment: Alignment.centerRight,
            width: nowBarWidth,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFEE286),
                  Color(0xFFFFD49D),
                  Color(0xFFFF9B2F),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                    color: Color(0x88FF871f),
                    offset: Offset(0, 4),
                    blurRadius: 12)
              ],
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),

        // 绿色机器人
        // Positioned(
        //   top: -halfHeight,
        //   left: nowBarWidth - halfHeight,
        //   child: Lottie.asset('assets/lottie/bot_run.json',
        //       width: trueHeight * 2,
        //       height: trueHeight * 2,
        //       fit: BoxFit.contain),
        // ),

        // 红色丸子
        // Positioned(
        //   left: nowBarWidth,
        //   child: Lottie.asset('assets/lottie/red_ball_run.json',
        //       width: trueHeight,
        //       height: trueHeight,
        //       fit: BoxFit.contain),

        // 橘猫
        Positioned(
          top: -offsetHeight,
          left: nowBarWidth - offsetHeight,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            child: Lottie.asset('assets/lottie/cat_run.json',
                width: trueHeight * 1.5,
                height: trueHeight * 1.5,
                fit: BoxFit.contain),
          ),
        )
      ],
    );
  }
}
