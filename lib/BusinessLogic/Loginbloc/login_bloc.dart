import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:meta_circles/Repositories/authentication_repostiory.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  LoginBloc() : super(LoginInitial()) {
    on<LoginingEvent>(
      (event, emit) async {
        emit(LoginLoading());
        final result = await _authenticationRepository.authenticateUser(
            event.email, event.password);
        log("LoginBlocResult:$result");
        if (result == "200") {
          emit(LoginSuccess());
        } else if (result != "200") {
          emit(LoginFailure(error: result));
        }
      },
    );
  }
}
