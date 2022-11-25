import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_bloc.dart';
import 'package:meta_circles/AppScreens/Theme/app_theme.dart';
import 'package:meta_circles/BottomNavigation/routes/routes.dart';
import 'package:meta_circles/BottomNavigation/routes/routes_names.dart';
import 'package:meta_circles/Repositories/auth_repositories.dart';
import 'package:meta_circles/Utils/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepositories(),
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
