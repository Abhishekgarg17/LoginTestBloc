import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_event.dart';
import 'package:meta_circles/AppScreens/AuthScreens/LoginScreen/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta_circles/AppScreens/AuthScreens/form_submission.dart';
import 'package:meta_circles/Repositories/auth_repositories.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepositories authRepo;
  LoginBloc(this.authRepo) : super(LoginState());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // EmailId updated
    if (event is LoginEmailIdChanged) {
      yield state.copyWith(emailId: event.emailId);
    }
    // Password updated
    else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);
    }
    // Form submitted
    else if (event is LoginSubmitted) {
      yield state.copyWith(formstatus: FormSubmitting());

      try {
        await authRepo.login();
        yield state.copyWith(formstatus: SubmissionSuccess());
      } catch (e) {
        yield state.copyWith(
            formstatus: SubmissionFailed(exception: Exception(e)));
      }
    }
  }
}
