import 'package:flutter/material.dart';

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
        Positioned(
          left: nowBarWidth,
          child: Transform.rotate(
            angle: nowRate * (3.14) * 2,
            child: Image.asset(
              'assets/image/loading_flag.webp',
              width: trueHeight,
              height: trueHeight,
            ),
          ),
        )
      ],
    );
  }
}
