import 'package:flutter/material.dart';

class KeyRedButton extends StatelessWidget {
  const KeyRedButton(
      {super.key,
      required this.data,
      this.onTap,
      this.colorFilter =
          const ColorFilter.mode(Colors.transparent, BlendMode.dst),
      this.fontSize = 44});

  final GestureTapCallback? onTap;
  final String data;
  final double fontSize;
  final ColorFilter colorFilter;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColorFiltered(
        colorFilter: colorFilter,
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
      ),
    );
  }
}

///Default matrix
List<double> get _matrix => [
      1, 0, 0, 0, 0, //R
      0, 1, 0, 0, 0, //G
      0, 0, 1, 0, 0, //B
      0, 0, 0, 1, 0, //A
    ];

///Generate a matrix of specified saturation
///[sat] A value of 0 maps the color to gray-scale. 1 is identity.
List<double> saturation(double sat) {
  final m = _matrix;
  final double invSat = 1 - sat;
  final double R = 0.213 * invSat;
  final double G = 0.715 * invSat;
  final double B = 0.072 * invSat;
  m[0] = R + sat;
  m[1] = G;
  m[2] = B;
  m[5] = R;
  m[6] = G + sat;
  m[7] = B;
  m[10] = R;
  m[11] = G;
  m[12] = B + sat;
  return m;
}


List<double> yellowFilter(double sat) {
  List<double> m = [
    1, 0, 0, 0, 0, //R
    0, 1, 0, 0, 0, //G
    0, 0, 1, 0, 0, //B
    0, 0, 0, 1, 0, //A
  ];
  final double invSat = 1 - 0.5;
  final double R = 0.213 * invSat;
  final double G = 0.715 * invSat;
  final double B = 0.072 * invSat;

  m[0] = R + sat;
  m[1] = G;
  m[2] = B;
  m[5] = R;
  m[6] = G + sat;
  m[7] = B;
  m[10] = R;
  m[11] = G;
  m[12] = B + sat;
  return m;
}
//FF0000
//FF3D00
