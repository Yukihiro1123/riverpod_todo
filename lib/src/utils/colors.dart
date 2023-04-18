import 'package:flutter/material.dart';

class ColorList {
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color red = Colors.red;
  static const Color blue = Color.fromRGBO(38, 153, 251, 1);
  static const Color skyBlue = Color.fromRGBO(188, 224, 253, 1);
  static const Color orange = Color.fromRGBO(251, 166, 38, 1);
  static const Color lightBlue = Color.fromRGBO(241, 249, 255, 1);
  static const Color lightGray = Color.fromRGBO(127, 127, 127, 1);
  static const Color veryLightBlue = Color.fromRGBO(127, 196, 253, 1);
  static const Color lightWhite = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color lightWhiteDiff = Color.fromRGBO(255, 255, 255, 0.8);
  static Color blue1 = HexColor("#27ABE3");
  static Color orange1 = HexColor("#E3A327");
  static Color black1 = HexColor("#111213");
  static Color gray1 = HexColor("#AFAFAF");
  static Color gray2 = HexColor("#D9D9D9");
  static Color gray3 = HexColor("#DBDBDB");
  static Color green1 = HexColor("#63EC23");
  static Color red1 = HexColor("#E22626");
  static Color white1 = HexColor("#FFFFFF");
  static Color darkGray1 = HexColor("#424242");
  static Color darkGray2 = HexColor("#33FFFFFF");
  static Color gold1Start = HexColor("#87705B");
  static Color gold1Middle = HexColor("#F9F0D0");
  static Color gold1End = HexColor("#BF966C");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
