abstract class LoginEvent {}

class LoginEmailIdChanged extends LoginEvent {
  final String emailId;

  LoginEmailIdChanged({required this.emailId});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});
}

class LoginSubmitted extends LoginEvent {}
