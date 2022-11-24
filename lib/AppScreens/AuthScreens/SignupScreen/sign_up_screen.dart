import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meta_circles/AppScreens/AuthScreens/SignupScreen/bloc/signup_bloc.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/blue_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/not_active_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/text_field_input.dart';
import 'package:meta_circles/core/sized_boxes.dart';
import 'package:provider/provider.dart';

import '../../../BottomNavigation/routes/routes_names.dart';
import '../../../Utils/app_size_config.dart';
import '../../Theme/colors.dart';
import '../../Theme/images.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final bloc = Provider.of<SignUpBloc>(context, listen: false);
    Uint8List? _image;
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSize.xLarge),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    TEXT_ICON,
                    color: darkThemeTextColor,
                    height: 64,
                  ),
                  vSizedBox3,
                  _UserAvatar(_image),
                  vSizedBox2,
                  // userName
                  _userNameTextField(bloc),
                  vSizedBox3,
                  _emailTextField(bloc),
                  vSizedBox3,
                  _phoneNumberTextField(bloc),
                  vSizedBox3,
                  _passwordTextField(bloc),
                  vSizedBox3,
                  _confirmPasswordTextField(bloc),
                  vSizedBox4,

                  // Button
                  StreamBuilder<Object>(
                      stream: bloc.isValid,
                      builder: (context, snapshot) {
                        return snapshot.hasError || !snapshot.hasData
                            ? const NotActiveButton(text: "Sign in")
                            : BlueButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content: SizedBox(
                                            height: 40,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator())),
                                      );
                                    },
                                  );
                                  bloc.submit(context);
                                },
                                text: "Sign up");
                      }),
                  vSizedBox3,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Already have an account?',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, RouteNames.loginScreen);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: const Text(
                            ' Login.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack _UserAvatar(Uint8List? _image) {
    return Stack(
      children: [
        _image != null
            ? CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(_image),
                backgroundColor: Colors.red,
              )
            : const CircleAvatar(
                radius: 64,
                backgroundImage:
                    NetworkImage('https://i.stack.imgur.com/l60Hf.png'),
                backgroundColor: Colors.red,
              ),
        Positioned(
          bottom: -10,
          left: 80,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_a_photo),
          ),
        )
      ],
    );
  }

  StreamBuilder<Object> _confirmPasswordTextField(SignUpBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.confirmPassword,
        builder: (context, snapshot) {
          return TextFieldInput(
              hintText: "Confirm Password",
              errorText: snapshot.error.toString() != 'null'
                  ? snapshot.error.toString()
                  : null,
              onChanged: bloc.changeConfirmPassword,
              showPass: () {},
              textInputType: TextInputType.name);
        });
  }

  StreamBuilder<Object> _passwordTextField(SignUpBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.password,
        builder: (context, snapshot) {
          return TextFieldInput(
              hintText: "Enter your password",
              errorText: snapshot.error.toString() != 'null'
                  ? snapshot.error.toString()
                  : null,
              onChanged: bloc.changePassword,
              showPass: () {},
              textInputType: TextInputType.name);
        });
  }

  StreamBuilder<Object> _phoneNumberTextField(SignUpBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.phoneNumber,
        builder: (context, snapshot) {
          return TextFieldInput(
              hintText: "Enter the Phone Number",
              errorText: snapshot.error.toString() != 'null'
                  ? snapshot.error.toString()
                  : null,
              onChanged: bloc.changePhoneNumber,
              showPass: () {},
              textInputType: TextInputType.name);
        });
  }

  StreamBuilder<Object> _emailTextField(SignUpBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.emailId,
        builder: (context, snapshot) {
          return TextFieldInput(
              hintText: "Email",
              errorText: snapshot.error.toString() != 'null'
                  ? snapshot.error.toString()
                  : null,
              onChanged: bloc.changeEmailId,
              showPass: () {},
              textInputType: TextInputType.name);
        });
  }

  StreamBuilder<Object> _userNameTextField(SignUpBloc bloc) {
    return StreamBuilder<Object>(
        stream: bloc.name,
        builder: (context, snapshot) {
          return TextFieldInput(
              hintText: "UserName",
              onChanged: (value) => bloc.changeName(value),
              showPass: () {},
              errorText: snapshot.error.toString() != 'null'
                  ? snapshot.error.toString()
                  : null,
              textInputType: TextInputType.name);
        });
  }
}
