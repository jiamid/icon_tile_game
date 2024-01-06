import 'dart:math';

import 'package:flutter/material.dart';

class BoxAnimationPage extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;
  final Color color;
  final Duration duration;
  final String img;
  final double startWidth;
  final double endWidth;

  const BoxAnimationPage({
    super.key,
    required this.startPosition,
    required this.endPosition,
    required this.color,
    required this.duration,
    required this.img,
    required this.startWidth,
    required this.endWidth,
  });

  @override
  BoxAnimationPageState createState() => BoxAnimationPageState();
}

class BoxAnimationPageState extends State<BoxAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; // 动画 controller
  late Animation<double> _animation; // 动画
  late double left; // 小圆点的left（动态计算）
  late double top; // 小远点的right（动态计算）

  late double diffWidth;

  @override
  void initState() {
    super.initState();
    diffWidth = widget.endWidth - widget.startWidth;
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    var x0 = widget.startPosition.dx;
    var y0 = widget.startPosition.dy;

    var x2 = widget.endPosition.dx;
    var y2 = widget.endPosition.dy;

    _animation.addListener(() {
      // t 动态变化的值
      var t = _animation.value;
      if (mounted) {
        setState(() {
          left = pow(1 - t, 2) * x0 + pow(t, 2) * x2;
          top = pow(1 - t, 2) * y0 + pow(t, 2) * y2;
        });
      }
    });

    // 初始化小圆点的位置
    left = widget.startPosition.dx;
    top = widget.startPosition.dy;

    // 显示小圆点的时候动画就开始
    _controller.forward();
  }

  double angle = 0;

  @override
  Widget build(BuildContext context) {
    var thisWidth = widget.startWidth + (diffWidth) * _controller.value;
    return Stack(
      children: <Widget>[
        Positioned(
          left: left,
          top: top,
          child: Container(
            width: thisWidth,
            height: thisWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.color, // 边框颜色
                width: 2.0, // 边框宽度
              ),
              color: widget.color,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.img,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
