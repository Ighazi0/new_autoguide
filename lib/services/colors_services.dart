import 'package:flutter/services.dart';

class ColorsServices {
  static Color fromHex(String hexString) {
    hexString = hexString.replaceAll('#', '');
    if (hexString.length == 6) {
      hexString = 'FF$hexString';
    }
    return Color(int.parse(hexString, radix: 16));
  }

  static Color hexToColor(String hex) {
    hex = hex.replaceFirst('#', '');
    return Color(int.parse('0xFF$hex'));
  }

  static String colorToHex(
    Color color,
  ) {
    int red = (color.r * 255).toInt();
    int green = (color.g * 255).toInt();
    int blue = (color.b * 255).toInt();

    String redHex = red.toRadixString(16).padLeft(2, '0');
    String greenHex = green.toRadixString(16).padLeft(2, '0');
    String blueHex = blue.toRadixString(16).padLeft(2, '0');

    return (redHex + greenHex + blueHex).toUpperCase();
  }
}
