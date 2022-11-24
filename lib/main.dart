import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_bloc.dart';
import 'package:meta_circles/AppScreens/AuthScreens/SignupScreen/bloc/signup_bloc.dart';
import 'package:meta_circles/AppScreens/AuthScreens/SignupScreen/sign_up_screen.dart';
import 'package:meta_circles/AppScreens/Theme/app_theme.dart';
import 'package:meta_circles/BottomNavigation/routes/routes.dart';
import 'package:meta_circles/BottomNavigation/routes/routes_names.dart';
import 'package:meta_circles/Utils/app_strings.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<SignUpBloc>(create: (context) => SignUpBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: AppTheme().Theme,
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: RouteNames.loginScreen,
      ),
    );
  }
}
