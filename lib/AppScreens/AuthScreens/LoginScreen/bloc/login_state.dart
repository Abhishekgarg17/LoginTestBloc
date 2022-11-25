import 'package:meta_circles/AppScreens/AuthScreens/form_submission.dart';

class LoginState {
  final String emailId;
  bool get isValidEmailId => emailId.length > 3;

  final String password;
  bool get isValidPassword => password.length > 2;

  final FormSubmissionStatus formstatus;
  LoginState(
      {this.emailId = "",
      this.password = "",
      this.formstatus = const InitialFormStatus()});

  LoginState copyWith({
    String? emailId,
    String? password,
    FormSubmissionStatus? formstatus,
  }) {
    return LoginState(
        emailId: this.emailId,
        password: this.password,
        formstatus: this.formstatus);
  }
}
