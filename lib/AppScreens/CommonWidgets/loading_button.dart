import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';

import '../../Utils/app_size_config.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: SizeConfig.heightMultiplier * 6,
      width: SizeConfig.widthMultiplier * 88,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: blueColor.withOpacity(0.3)),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color:
            theme.copyWith(indicatorColor: darkThemeTextColor).indicatorColor,
      ),
    );
  }
}
