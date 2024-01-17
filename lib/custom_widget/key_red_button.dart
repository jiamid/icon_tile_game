import 'package:flutter/material.dart';

class KeyRedButton extends StatelessWidget {
  const KeyRedButton({super.key, required this.data, this.onTap});

  final GestureTapCallback? onTap;
  final String data;

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
        child: Text(
          data,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 44,
              height: 1.3,
              fontFamily: 'Baloo2',
              shadows: [
                Shadow(
                    color: Color(0xFFA42E00),
                    blurRadius: 0,
                    offset: Offset(0, 3))
              ],
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
