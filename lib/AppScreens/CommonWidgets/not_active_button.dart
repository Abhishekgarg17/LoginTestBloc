import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';
import 'package:meta_circles/Utils/app_size_config.dart';

class NotActiveButton extends StatelessWidget {
  final String text;
  const NotActiveButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: SizeConfig.heightMultiplier * 6,
      width: SizeConfig.widthMultiplier * 88,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: blueColor.withOpacity(0.3)),
      child: Text(
        text,
        style: TextStyle(
          color: theme.cardColor.withOpacity(0.9),
          fontSize: AppSize.large,
        ),
      ),
    );
  }
}
