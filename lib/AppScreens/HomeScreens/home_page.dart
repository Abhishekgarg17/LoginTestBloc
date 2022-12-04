import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_circles/BottomNavigation/routes/routes_names.dart';
import '../../BusinessLogic/Authenticationbloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: const Text('logout'),
          onPressed: () {
            Navigator.pushNamed(context, RouteNames.loginScreen);
            // BlocProvider.of<AuthenticationBloc>(context).on((event, emit) => ecen)
          },
        )),
      ),
    );
  }
}
