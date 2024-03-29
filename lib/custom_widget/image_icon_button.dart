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

buildImageButton(String imgPath,
    {GestureTapCallback? onTap,
    int? times,
    double width = 60,
    double height = 60}) {
  List<Widget> stackChildren = [
    SizedBox(
        height: width,
        width: height,
        child: GestureDetector(
          onTap: onTap,
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

buildGoldButton(String imgPath, int gold,
    {GestureTapCallback? onTap, double height = 40}) {
  List<Widget> stackChildren = [
    SizedBox(
      height: height,
      width: double.infinity,
      child: Image.asset(
        imgPath,
        fit: BoxFit.contain,
        alignment: Alignment.centerLeft,
      ),
    ),
  ];
  stackChildren.add(Positioned(
    left: height,
    child: Text(
      gold.toString(),
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: height / 2,
          height: 2,
          fontFamily: 'Baloo2',
          shadows: const [
            Shadow(
                color: Color(0xFFB45509), blurRadius: 0, offset: Offset(0, 2))
          ],
          decoration: TextDecoration.none),
    ),
  ));
  return GestureDetector(onTap: onTap, child: Stack(children: stackChildren));
}
