import 'package:flutter/material.dart';

final Color darkThemeColor = getColorFromHexValue('#000000');

const Color darkThemeTextColor = Colors.white;

final Color blueColor = Color.fromARGB(255, 23, 139, 234);

final greyTextColor = Colors.grey[400];

final greyColorWithOpacity = Colors.grey[500]!.withOpacity(0.5);

/// get Color object for the given [hexColor] hex value
Color getColorFromHexValue(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }
  return Color(int.parse(hexColor, radix: 16));
}
