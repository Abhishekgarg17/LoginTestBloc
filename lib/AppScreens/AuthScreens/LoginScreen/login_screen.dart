import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_bloc.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/blue_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/loading_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/not_active_button.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';
import 'package:meta_circles/AppScreens/Theme/images.dart';
import 'package:meta_circles/Utils/app_size_config.dart';
import 'package:meta_circles/core/sized_boxes.dart';
import 'package:provider/provider.dart';
import '../../../BottomNavigation/routes/routes_names.dart';
import '../../CommonWidgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    bloc.dispose();
    super.dispose();
  }

  String data = "Log in";
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
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

              StreamBuilder<String>(
                  stream: bloc.loginEmail,
                  builder: (context, snapshot) {
                    return TextFieldInput(
                      showPass: () {},
                      // ignore: prefer_if_null_operators
                      errorText: snapshot.error.toString() != 'null'
                          ? snapshot.error.toString()
                          : null,
                      onChanged: bloc.changeloginEmail,
                      hintText: 'Phone number, email or username',
                      textInputType: TextInputType.emailAddress,
                      isPass: false,
                    );
                  }),
              vSizedBox3,

              // Password Field
              StreamBuilder<String>(
                  stream: bloc.loginPassword,
                  builder: (context, snapshot) {
                    return TextFieldInput(
                      hintText: 'Password',
                      showPass: () {},
                      isPass: true,
                      errorText: snapshot.error.toString() != 'null'
                          ? snapshot.error.toString()
                          : null,
                      onChanged: bloc.changeLoginPassword,
                      textInputType: TextInputType.text,
                    );
                  }),
              vSizedBox3,

              // Login Button
              StreamBuilder<Object>(
                  stream: bloc.isValid,
                  builder: (context, snapshot) {
                    return snapshot.hasError || !snapshot.hasData
                        ? const NotActiveButton(text: "Log in")
                        : BlueButton(
                            onPressed: () {
                              bloc.submit(context);

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
                            },
                            text: data);
                  }),
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
                      Navigator.pushNamed(context, RouteNames.signupScreen);
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
      ),
    ));
  }
}
