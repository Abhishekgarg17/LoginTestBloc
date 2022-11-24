import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';

class BlueButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const BlueButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialButton(
      onPressed: onPressed,
      color: blueColor,
      minWidth: 600,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      height: 45,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(color: darkThemeTextColor),
      ),
    );
  }
}
