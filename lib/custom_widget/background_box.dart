import 'package:flutter/material.dart';

class BackgroundBox extends StatelessWidget {
  const BackgroundBox({super.key, required this.image, this.color, this.child});

  final ImageProvider image;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: color),
            child: child));
  }
}
