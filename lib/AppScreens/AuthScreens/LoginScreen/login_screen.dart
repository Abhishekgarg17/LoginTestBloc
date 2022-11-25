import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_bloc.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_event.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_state.dart';
import 'package:meta_circles/AppScreens/AuthScreens/form_submission.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/blue_button.dart';
import 'package:meta_circles/AppScreens/CommonWidgets/loading_button.dart';
import 'package:meta_circles/AppScreens/Theme/colors.dart';
import 'package:meta_circles/AppScreens/Theme/images.dart';
import 'package:meta_circles/Repositories/auth_repositories.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String data = "Log in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkThemeColor,
      body: BlocProvider(
        create: (context) => LoginBloc(context.read<AuthRepositories>()),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSize.xLarge),
          child: _loginForm(formKey: _formKey, data: data),
        ),
      ),
    ));
  }
}

class _loginForm extends StatelessWidget {
  const _loginForm({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.data,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Form(
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

          _emailTextField(),

          vSizedBox3,

          // Password Field

          _passwordField(),

          vSizedBox3,
          // Login Button
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return state.formstatus is FormSubmitting
                  ? const LoadingButton()
                  : BlueButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LoginBloc>().add(LoginSubmitted());
                        }
                      },
                      text: data);
            },
          ),

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
                style: TextStyle(color: blueColor, fontWeight: FontWeight.w600),
              )
            ],
          ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFieldInput(
          hintText: 'Password',
          validator: (value) =>
              state.isValidPassword ? null : "Password is too short",
          showPass: () {},
          isPass: true,
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChanged(password: value)),
          textInputType: TextInputType.text,
        );
      },
    );
  }

  Widget _emailTextField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextFieldInput(
          showPass: () {},
          validator: (value) =>
              state.isValidEmailId ? null : "UserName is too Short",
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginEmailIdChanged(emailId: value)),
          hintText: 'Phone number, email or username',
          textInputType: TextInputType.emailAddress,
          isPass: false,
        );
      },
    );
  }
}
