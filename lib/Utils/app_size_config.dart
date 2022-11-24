import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// MediaQuery is defined for height , width, text and image separetly

extension AdaptiveSize on num {
  double get adapt =>
      ((SizeConfig.heightMultiplier * SizeConfig.widthMultiplier) /
          (414 * 896)) *
      this *
      100 *
      100;
}

class SizeConfig {
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockWidth;
  static late double _blockHeight;

  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;
  static late double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final size = MediaQuery.of(context).size;
    if (orientation == Orientation.portrait) {
      _screenWidth = size.width;
      _screenHeight = size.height;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = size.width;
      _screenHeight = size.height;
      isPortrait = false;
      isMobilePortrait = false;
    }
    // horizontal
    _blockWidth = _screenWidth / 100;
    // vertical
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;

    // Divide the size first like 28/vertical then multiply the result with the textmultiplier
  }
}

class AppSize {
  AppSize._();
  static final double small = 8.adapt;
  static final double medium = 16.adapt;
  static final double large = 24.adapt;
  static final double xLarge = 32.adapt;
  static final double xxLarge = 48.adapt;
  static final double largest = 72.adapt;
  static const double infinite = double.infinity;
}
