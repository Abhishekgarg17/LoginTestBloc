import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../Utils/network_handler.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(
      (event, emit) {
        print(event.emailId);
        print(event.password);
        emit(LoginLoading());
        // try {
        //   authenticateUser(event.emailId, event.password);
        //   emit(LoginInitial());
        // } catch (error) {
        //   emit(LoginFailure(error: error.toString()));
        // }
      },
    );
  }
}

Future<void> authenticateUser(String email, String password) async {
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

      print("user entered");
    } else if (response.statusCode == 206) {
      throw Exception("No Core Details Exist");
    } else {
      throw Exception(json.decode(response.body)['error']);
    }
  } catch (e) {
    Network.handleError(e, showCustomMessage: true);
  }
}
