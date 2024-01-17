import 'package:flutter/material.dart';

class ImageIconButton extends StatelessWidget {
  const ImageIconButton(
      {super.key, required this.image, this.onTap, this.times, this.size = 64});

  final String image;
  final GestureTapCallback? onTap;
  final int? times;
  final double size;

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [
      SizedBox(
        width: size,
        height: size,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image/icon_bg.webp'),
                    fit: BoxFit.contain)),
            child: Padding(
                padding: EdgeInsets.all(size * 0.2),
                child: Image.asset(
                  image,
                )),
          ),
        ),
      )
    ];
    if (times != null) {
      stackChildren.add(Positioned(
          left: 40,
          child: Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red,
            ),
            child: Text(
              times.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  height: 1.1,
                  fontFamily: 'Baloo2',
                  shadows: [
                    Shadow(
                        color: Color(0xFFB45509),
                        blurRadius: 0,
                        offset: Offset(0, 2))
                  ],
                  decoration: TextDecoration.none),
            ),
          )));
    }
    return Stack(children: stackChildren);
  }
}

buildImageButton(imgPath, onPressed, {times, double size = 60}) {
  List<Widget> stackChildren = [
    SizedBox(
        height: size,
        width: size,
        child: GestureDetector(
          onTap: onPressed,
          child: Image.asset(imgPath),
        )),
  ];
  if (times != null) {
    stackChildren.add(Positioned(
        left: 40,
        child: Container(
          height: 20,
          width: 20,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.red,
          ),
          child: Text(
            times,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 20,
                height: 1.1,
                fontFamily: 'Baloo2',
                shadows: [
                  Shadow(
                      color: Color(0xFFB45509),
                      blurRadius: 0,
                      offset: Offset(0, 2))
                ],
                decoration: TextDecoration.none),
          ),
        )));
  }
  return Stack(children: stackChildren);
}
