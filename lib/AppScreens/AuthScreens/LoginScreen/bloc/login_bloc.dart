import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meta_circles/BottomNavigation/routes/routes_names.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../Utils/network_handler.dart';
import '../../../../Utils/validators.dart';

class LoginBloc with Validators {
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //Getters
  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(loginPasswordValidator);

  Stream<bool> get isValid =>
      Rx.combineLatest2(loginEmail, loginPassword, (loginEmail, pass) => true);

  //Setters
  Function(String) get changeloginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;

  void submit(context) {
    authenticateUser(_loginEmail.value, _loginPassword.value, context);
  }

  //Dispose
  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
  }
}

Future<void> authenticateUser(
    String email, String password, BuildContext context) async {
  var body = json.encode({
    'email': email,
    'password': password,
  });
  late http.Response response;

  try {
    response = await Network.call(
      API_CALL_TYPE.POST,
      '/api/v2/user/main/fetch/',
      body: body,
    );
    if (response.statusCode == 200) {
      // user = User.fromJson(json.decode(response.body));
      // await this.getUserCoreData(context);
      // this.isUserLoggedIn = true;
      // checkIfUserConsultant();
      Navigator.pushReplacementNamed(context, RouteNames.signupScreen);

      log("User Entered");
      print("user entered");
    } else if (response.statusCode == 206) {
      throw Exception("No Core Details Exist");
    } else
      throw Exception(json.decode(response.body)['error']);
  } catch (e) {
    Navigator.pop(context);

    Network.handleError(e, showCustomMessage: true);
  }
}
