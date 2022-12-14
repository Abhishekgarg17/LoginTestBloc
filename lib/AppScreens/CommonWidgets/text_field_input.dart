import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';

// ignore: must_be_immutable
class TextFieldInput extends StatefulWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  String? errorText;
  final TextInputType textInputType;
  VoidCallback showPass;
  TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.validator,
    this.isPass = false,
    required this.hintText,
    required this.onChanged,
    required this.showPass,
    this.errorText,
    required this.textInputType,
  }) : super(key: key);

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );

    return TextFormField(
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.textEditingController,
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        fillColor: greyColorWithOpacity,
        focusColor: blueColor,
        hintText: widget.hintText,
        errorText: widget.errorText,
        border: inputBorder,
        hintStyle: TextStyle(color: greyTextColor),
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: widget.textInputType,
      obscureText: widget.isPass,
    );
  }
}
