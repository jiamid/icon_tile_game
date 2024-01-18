import 'package:flutter/material.dart';

class KeyRedButton extends StatelessWidget {
  const KeyRedButton(
      {super.key, required this.data, this.onTap, this.fontSize = 44});

  final GestureTapCallback? onTap;
  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/image/key_button_bg.webp'),
                fit: BoxFit.contain)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            data,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: fontSize,
                height: 1,
                fontFamily: 'Baloo2',
                shadows: const [
                  Shadow(
                      color: Color(0xFFA42E00),
                      blurRadius: 0,
                      offset: Offset(0, 3))
                ],
                decoration: TextDecoration.none),
          ),
        ),
      ),
    );
  }
}
