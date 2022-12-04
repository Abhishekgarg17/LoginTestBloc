import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/blue_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/custom_snackbar.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/loading_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/text_field_input.dart';
import 'package:meta_circles/core/sized_boxes.dart';
import '../../../BottomNavigation/routes/routes_names.dart';
import '../../../BusinessLogic/Signupbloc/signup_bloc.dart';
import '../../../Utils/app_size_config.dart';
import '../../../Utils/constants.dart';
import '../../Theme/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  final TextEditingController _emailContorller = TextEditingController();
  final TextEditingController _nameContorller = TextEditingController();
  final TextEditingController _phoneNumberControleer = TextEditingController();
  final TextEditingController _passwordContorller = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscureText = true;
  bool _confirmPasswordObsecure = true;
  Uint8List? _image;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailContorller.dispose();
    _nameContorller.dispose();
    _phoneNumberControleer.dispose();
    _passwordContorller.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSize.xLarge),
          child: Form(
            key: _signupFormKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Meta Circles",
                    style: TextStyle(fontSize: 46),
                  ),
                  vSizedBox3,
                  _userAvatar(_image),
                  vSizedBox2,
                  // userName
                  _nameTextField(),
                  vSizedBox3,
                  _emailTextField(),
                  vSizedBox3,
                  _phoneNumberTextField(),
                  vSizedBox3,
                  _passwordTextField(),
                  vSizedBox3,
                  _confirmTextField(),
                  vSizedBox4,

                  // Button
                  _signupButton(),
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
                          Navigator.pushReplacementNamed(
                              context, RouteNames.loginScreen);
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

  BlocConsumer<SignupBloc, SignupState> _signupButton() {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          showSuccessSnackbar("Successfully Registered", context);
          _emailContorller.clear();
          _nameContorller.clear();
          _confirmPasswordController.clear();
          _passwordContorller.clear();
          _phoneNumberControleer.clear();
          Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
        } else if (state is SignupFailure) {
          showFailureSnackbar(state.error, context);
        }
      },
      builder: (context, state) {
        if (state is SignupLoading) {
          return const LoadingButton();
        } else {
          return BlueButton(
              onPressed: () {
                BlocProvider.of<SignupBloc>(context).add(
                    SignupButtonOnpressedEvent(
                        email: _emailContorller.text,
                        name: _nameContorller.text,
                        password: _passwordContorller.text,
                        phone: _phoneNumberControleer.text));
              },
              text: "Sign up");
        }
      },
    );
  }

  _confirmTextField() {
    return TextFormField(
      onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _confirmPasswordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Enter the Valid Password";
        } else if (value != _passwordContorller.text) {
          return "Passoword not matches";
        } else if (value.length < 6) {
          return "The length of Password must be greater than or equal to 6";
        }
        return null;
      },
      obscureText: _confirmPasswordObsecure,
      decoration: InputDecoration(
        fillColor: greyColorWithOpacity,
        focusColor: blueColor,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _confirmPasswordObsecure = !_confirmPasswordObsecure;
            });
          },
          child: Icon(_confirmPasswordObsecure
              ? Icons.visibility_off
              : Icons.visibility),
        ),
        hintText: "Confirm Password",
        border:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        hintStyle: TextStyle(color: greyTextColor),
        focusedBorder:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        enabledBorder:
            OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }

  _passwordTextField() {
    {
      return TextFormField(
        onEditingComplete: () {
        FocusScope.of(context).nextFocus();
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: _passwordContorller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please Enter the Valid Password";
          } else if (value.length < 6) {
            return "The length of Password must be greater than or equal to 6";
          }
          return null;
        },
        obscureText: _obscureText,
        decoration: InputDecoration(
          fillColor: greyColorWithOpacity,
          focusColor: blueColor,
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
          ),
          hintText: "Password",
          border:
              OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
          hintStyle: TextStyle(color: greyTextColor),
          focusedBorder:
              OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
          enabledBorder:
              OutlineInputBorder(borderSide: Divider.createBorderSide(context)),
          filled: true,
          contentPadding: const EdgeInsets.all(8),
        ),
      );
    }
  }

  TextFieldInput _phoneNumberTextField() {
    return TextFieldInput(
        textEditingController: _phoneNumberControleer,
        validator: (value) {
          if (!regexMobile.hasMatch(_phoneNumberControleer.text.trim())) {
            return "Please enter the valid mobile";
          }
          if (value == null || value.isEmpty) {
            return "Required";
          } else {
            return null;
          }
        },
        hintText: "Phone Number",
        onChanged: (p0) {},
        showPass: () {},
        textInputType: TextInputType.name);
  }

  TextFieldInput _emailTextField() {
    return TextFieldInput(
        textEditingController: _emailContorller,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Required';
          }
          if ((!regexEmail.hasMatch(_emailContorller.text.trim())) &&
              (!regexMobile.hasMatch(_emailContorller.text.trim()))) {
            return 'Please enter a valid email or mobile';
          } else {
            return null;
          }
        },
        hintText: "Email",
        onChanged: (p0) {},
        showPass: () {},
        textInputType: TextInputType.emailAddress);
  }

  TextFieldInput _nameTextField() {
    return TextFieldInput(
        textEditingController: _nameContorller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Required";
          } else {
            return null;
          }
        },
        hintText: "Name",
        onChanged: (p0) {},
        showPass: () {},
        textInputType: TextInputType.name);
  }

  Stack _userAvatar(Uint8List? image) {
    return Stack(
      children: [
        image != null
            ? CircleAvatar(
                radius: 64,
                backgroundImage: MemoryImage(image),
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
}
