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
  late bool isShow;
  LoginBloc() : super(LoginInitial()) {
    on<LoginingEvent>(
      (event, emit) async {
        emit(LoginLoading());
        final result = await authenticateUser(event.email, event.password);
        log("LoginBlocResult:$result");
        if (result == "200") {
          emit(LoginSuccess());
        } else if (result != "200") {
          emit(LoginFailure(error: result));
        }
      },
    );

    on<ShowPassoword>((event, emit) {
      if (isShow == false) {
        isShow = true;
      } else {
        isShow = false;
      }
    });
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
      log("LoginBloc:User Entered or Successfully Login");
    } else if (response.statusCode == 206) {
      throw Exception("No Core Details Exist");
    } else {
      throw Exception(json.decode(response.body)['error']);
    }
  } catch (e) {
    log(response.statusCode.toString());
    return json.decode(response.body)['error'];
  }
  return response.statusCode.toString();
}
