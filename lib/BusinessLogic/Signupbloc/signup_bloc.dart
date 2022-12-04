import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../Repositories/authentication_repostiory.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  SignupBloc() : super(SignupInitial()) {
    on<SignupButtonOnpressedEvent>((event, emit) async {
      emit(SignupLoading());
      final result = await _authenticationRepository.registerUser(
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


