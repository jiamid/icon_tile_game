import 'package:flutter/material.dart';

class KeyZooBoard extends StatelessWidget {
  const KeyZooBoard(
      {super.key, required this.data, this.onTap, this.fontSize = 64});

  final GestureTapCallback? onTap;
  final String data;
  final double fontSize;

  buildTextStyle(double borderWidth, Color borderColor,
      {PaintingStyle style = PaintingStyle.stroke}) {
    return TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: fontSize,
      letterSpacing: 2,
      fontFamily: 'Baloo2',
      foreground: Paint()
        ..style = style
        ..strokeWidth = borderWidth
        ..color = borderColor,
    );
  }

  Size getTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return Size(textPainter.width, textPainter.height);
  }

  @override
  Widget build(BuildContext context) {
    var size =
        getTextWidth(data, buildTextStyle(17.0, const Color(0xFFB45509)));
    double diff = 20;
    double half = diff / 2;
    return GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/key_board_bg.webp'),
                    fit: BoxFit.contain)),
            child: Stack(children: [
              SizedBox(
                width: size.width + diff,
                height: size.height + diff,
              ),
              Positioned(
                  left: half,
                  top: half + 2,
                  child: Text(data,
                      style: buildTextStyle(16.0, const Color(0xFFB45509)))),
              Positioned(
                  left: half,
                  top: half,
                  child: Text(data,
                      style: buildTextStyle(16.0, const Color(0xFF57180E)))),
              Positioned(
                  left: half,
                  top: half + 2,
                  child: Text(data,
                      style: buildTextStyle(5.0, const Color(0xFFB45509)))),
              Positioned(
                  left: half,
                  top: half,
                  child: Text(data,
                      style: buildTextStyle(5.0, const Color(0xFFFFD63D)))),
              Positioned(
                  left: half,
                  top: half,
                  child: Text(data,
                      style: buildTextStyle(0.0, Colors.white,
                          style: PaintingStyle.fill))),
            ])));
  }
}
