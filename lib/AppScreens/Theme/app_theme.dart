import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';

class AppTheme extends ChangeNotifier {
  final ThemeData _darkTheme = ThemeData(
      backgroundColor: darkThemeColor,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: darkThemeTextColor,
        backgroundColor: darkThemeColor,
        brightness: Brightness.dark,
      ),
      // define the themes for the Text 
      textTheme: TextTheme(),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: blueColor, selectionColor: darkThemeTextColor));

  ThemeData get Theme => _darkTheme;
}
