import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../Utils/network_handler.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginingEvent>(
      (event, emit) async {
        emit(LoginLoading());
        print(event.email);
        print(event.password);
        final result = await authenticateUser(event.email, event.password);
        log("Result:$result");
        if (result == "200") {
          emit(LoginSuccess());
        } else if (result == "404") {
          emit(const LoginFailure(error: "User not Found"));
        } else if (result != "200") {
          emit(const LoginFailure(error: "Failed to Login"));
        }
      },
    );
  }
}

Future<dynamic> authenticateUser(String email, String password) async {
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
    log(response.statusCode.toString());
    return response.statusCode.toString();

    // Network.handleError(e, showCustomMessage: true);
  }
  return response.statusCode.toString();
}
