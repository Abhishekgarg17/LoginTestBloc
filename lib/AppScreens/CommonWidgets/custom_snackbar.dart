import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';

void showSuccessSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: greenColor,
      content: Text(
        message,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context)
                .copyWith(canvasColor: whiteColor)
                .canvasColor),
      )));
}

void showFailureSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: redColor,
      content: Text(
        message,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context)
                .copyWith(canvasColor: whiteColor)
                .canvasColor),
      )));
}
