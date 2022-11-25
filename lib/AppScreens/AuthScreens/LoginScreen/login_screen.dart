import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_bloc.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/blue_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/loading_button.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';
import 'package:meta_circles/AppScreens/Theme/images.dart';
import 'package:meta_circles/Utils/app_size_config.dart';
import 'package:meta_circles/core/sized_boxes.dart';
import '../../../BottomNavigation/routes/routes_names.dart';
import '../../CommonWidgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailContorller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static String patternEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regexEmail = new RegExp(patternEmail);

  static String patternMobile = r'^[6-9]\d{9}$';
  RegExp regexMobile = new RegExp(patternMobile);

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
                    SvgPicture.asset(
                      TEXT_ICON,
                      color: darkThemeTextColor,
                      height: 64,
                    ),
                    vSizedBox5,

                    // Email Field

                    TextFieldInput(
                      textEditingController: _emailContorller,
                      validator: (val) {
                        if (val == null || val.length == 0) {
                          return 'Required';
                        }
                        if ((!regexEmail.hasMatch(
                            _emailContorller.text.trim())) &&
                            (!regexMobile.hasMatch(
                                _emailContorller.text.trim()))) {
                          return 'Please enter a valid email \n or mobile';
                        } else
                          return null;
                      },
                      showPass: () {},
                      // ignore: prefer_if_null_operators

                      onChanged: (p0) {},
                      hintText: 'Phone number, email or username',
                      textInputType: TextInputType.emailAddress,
                      isPass: false,
                    ),

                    vSizedBox3,
                    // Password Field
                    TextFieldInput(
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Required';
                        }
                        if (value.length < 6) {
                          return 'Password must be of atleast 6 characters.';
                        }
                        return null;
                      },
                      textEditingController: _passwordController,
                      hintText: 'Password',
                      showPass: () {},
                      isPass: false,
                      onChanged: (p0) {},
                      textInputType: TextInputType.text,
                    ),
                    vSizedBox3,

                    // Login Button
                    BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          Navigator.pushNamed(
                              context, RouteNames.homepageScreen);
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is LoginLoading) {
                          return const LoadingButton();
                        } else {
                          return BlueButton(
                              onPressed: () {
                                BlocProvider.of<LoginBloc>(context).add(
                                    LoginingEvent(
                                        email: _emailContorller.text,
                                        password: _passwordController.text));
                              },
                              text: "Log in");
                        }
                      },
                    ),
                    // BlocBuilder<LoginBloc, LoginState>(
                    //   builder: (context, state) {
                    //     if (state is LoginLoading) {
                    //       return const LoadingButton();
                    //     } else {
                    //       return BlueButton(
                    //           onPressed: () {
                    //             BlocProvider.of<LoginBloc>(context).add(
                    //                 LoginingEvent(
                    //                     email: _emailContorller.text,
                    //                     password:
                    //                         _passwordController.text));
                    //           },
                    //           text: "Log in");
                    //     }
                    //   },
                    // ),
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
                            Navigator.pushNamed(
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
}
