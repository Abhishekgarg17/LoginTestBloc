import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../BusinessLogic/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: const Text('logout'),
          onPressed: () {
            // BlocProvider.of<AuthenticationBloc>(context).on((event, emit) => ecen)
          },
        )),
      ),
    );
  }
}
