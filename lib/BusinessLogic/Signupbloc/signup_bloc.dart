import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import '../../../Utils/network_handler.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonOnpressedEvent>((event, emit) async {
      emit(SignupLoading());
      final result = await registerUser(
          event.name, event.email, event.password, event.phone);
      log("SignupBloc: $result");
      if (result == "200") {
        emit(SignupSuccess());
      } else if (result != "200") {
        emit(SignupFailure(error: result.toString()));
      }
    });
  }
}

Future<dynamic> registerUser(
    String name, String email, String password, String phone) async {
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
      log("User registered");

      // user = User.fromJson(json.decode(response.body));
    } else {
      throw Exception(json.decode(response.body)['error']);
    }
  } catch (e) {
    log(response.body.toString());
    return json.decode(response.body)['error'];
  }
  return response.statusCode.toString();
}
