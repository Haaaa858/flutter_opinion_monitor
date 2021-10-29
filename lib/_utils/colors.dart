import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

class HiColors {
  static MaterialColor pink = MaterialColor(0xfffb7299, <int, Color>{
    50: Color(0xffFCB7CB),
    100: Color(0xffFCA9C0),
    200: Color(0xffFB9BB6),
    300: Color(0xffFB8DAC),
    400: Color(0xffFA7EA2),
    500: Color(0xfffb7299),
    600: Color(0xffE16588),
    700: Color(0xffC85A79),
    800: Color(0xffAF4F6A),
    900: Color(0xff96435B),
  });

  static MaterialColor white = createMaterialColor(Colors.white);
}
