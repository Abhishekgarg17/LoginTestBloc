import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import '../../../../Utils/network_handler.dart';
import '../../../../Utils/validators.dart';

class SignUpBloc with Validators {
  final _name = BehaviorSubject<String>();
  final _emailId = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

//Getters
  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get emailId => _emailId.stream.transform(emailValidator);
  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(phoneValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get confirmPassword =>
      _confirmPassword.stream.transform(confirmPasswordValidator);

  Stream<bool> get isValid => Rx.combineLatest5(name, emailId, phoneNumber,
      password, confirmPassword, (name, email, phone, pass, confPass) => true);

  ///`To match the password`
  Stream<bool> get passwordMatch =>
      Rx.combineLatest2(password, confirmPassword, (pass, confPass) {
        if (pass != confPass) {
          return false;
        } else {
          return true;
        }
      });

//Setters
  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmailId => _emailId.sink.add;
  Function(String) get changePhoneNumber => _phoneNumber.sink.add;
  Function(String) get changePassword => _password.sink.add;
  Function(String) get changeConfirmPassword => _confirmPassword.sink.add;

//Submit
  void submit(context) {
    print("Password ${_password.value}");
    print(_confirmPassword.value);
    if (_password.value != _confirmPassword.value) {
      _confirmPassword.sink.addError("Password doesn't match");
    } else {
      registerUser(_name.value, _emailId.value, _password.value,
          _phoneNumber.value, context);
      print(_name.value);
      print(_emailId.value);
      print(_phoneNumber.value);
      print(_password.value);
      print(_confirmPassword.value);
    }
  }

//dispose
  void dispose() {
    _name.close();
    _emailId.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }

  Future<void> registerUser(String name, String email, String password,
      String phone, BuildContext context) async {
    late http.Response response;
    try {
      response = await Network.call(
        API_CALL_TYPE.POST,
        '/api/v2/user/main/create/',
        body: json.encode({
          'first_name': name,
          'email': email,
          'password': password,
          'platform': 'THCAPP',
          'phone': phone
        }),
      );
      if (response.statusCode == 200) {
        print("registered");
        Navigator.pop(context);

        // user = User.fromJson(json.decode(response.body));
      } else
        throw Exception(json.decode(response.body)['error']);
    } catch (e) {
      Network.handleError(e, showCustomMessage: true);
    }
  }
}
