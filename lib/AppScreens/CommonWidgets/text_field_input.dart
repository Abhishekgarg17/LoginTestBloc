import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';

class TextFieldInput extends StatefulWidget {
  // final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  String? Function(String?)? validator;
  void Function(String)? onChanged;
  String? errorText;
  final TextInputType textInputType;
  VoidCallback showPass;
  TextFieldInput({
    Key? key,
    // required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.onChanged,
    required this.validator,
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
      // controller: widget.textEditingController,
      validator: widget.validator,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        fillColor: greyColorWithOpacity,
        focusColor: blueColor,
        hintText: widget.hintText,
        errorText: widget.errorText,
        border: inputBorder,
        hintStyle: TextStyle(color: greyTextColor),
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: widget.showPass,
                icon: widget.isPass
                    ? const Icon(Icons.lock_outline)
                    : const Icon(Icons.lock_open_outlined),
              )
            : null,
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
