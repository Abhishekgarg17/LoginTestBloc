import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/blue_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/custom_snackbar.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/loading_button.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';
import 'package:meta_circles/AppScreens/Theme/images.dart';
import 'package:meta_circles/BusinessLogic/Loginbloc/login_bloc.dart';
import 'package:meta_circles/Utils/app_size_config.dart';
import 'package:meta_circles/core/sized_boxes.dart';
import '../../../BottomNavigation/routes/routes_names.dart';
import '../../../Utils/constants.dart';
import '../../CommonWidgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailContorller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailContorller.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: darkThemeColor,
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: AppSize.xLarge),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                    const Text(
                      "Meta Circles",
                      style: TextStyle(fontSize: 46),
                    ),
                    vSizedBox8,
                    // Email Field
                    _emailTextFeild(),

                    vSizedBox3,
                    // Password Field
                    _passowordTextField(),
                    vSizedBox3,
                    // Login Button
                    _loginButton(),
                    vSizedBox3,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Dont have an account?',
                          style: TextStyle(color: darkThemeTextColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, RouteNames.signupScreen);
                          },
                          child: const Text(
                            ' Signup.',
                            style: TextStyle(
                              color: darkThemeTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    vSizedBox2,
                    const Text(
                      "OR",
                      style: TextStyle(color: Colors.white),
                    ),
                    vSizedBox2,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          FACEBOOK_ICON,
                          height: SizeConfig.heightMultiplier * 4,
                        ),
                        hSizedBox1,
                        Text(
                          "Log in with Facebook",
                          style: TextStyle(
                              color: blueColor, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            )));
  }

  BlocConsumer<LoginBloc, LoginState> _loginButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          showSuccessSnackbar("Successfully Login", context);
          _emailContorller.clear();
          _passwordController.clear();
          Navigator.pushReplacementNamed(context, RouteNames.homepageScreen);
        } else if (state is LoginFailure) {
          showFailureSnackbar(state.error, context);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const LoadingButton();
        } else {
          return BlueButton(
              onPressed: () {
                BlocProvider.of<LoginBloc>(context).add(LoginingEvent(
                    email: _emailContorller.text,
                    password: _passwordController.text));
              },
              text: "Log in");
        }
      },
    );
  }

  _passowordTextField() {
    return TextFormField(
      controller: _passwordController,
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

  TextFieldInput _emailTextFeild() {
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
      showPass: () {},
      onChanged: (p0) {},
      hintText: 'Phone number, email or username',
      textInputType: TextInputType.emailAddress,
      isPass: false,
    );
  }
}
