import 'package:flutter/material.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/login_screen.dart';
import 'package:meta_circles/AppScreens/AuthScreens/SignupScreen/sign_up_screen.dart';
import 'package:meta_circles/BottomNavigation/routes/routes_names.dart';

class Routes {
  Routes._();

  // Normal Routes

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );

      case RouteNames.signupScreen:
        return MaterialPageRoute(builder: (context) => const SignupScreen());

      default:
        null;
    }
    return null;
  }
}
