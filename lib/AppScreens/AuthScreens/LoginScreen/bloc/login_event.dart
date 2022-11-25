part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String emailId;

  const LoginEmailChanged(required, this.emailId);
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged(required, this.password);
}

class LoginButtonPressed extends LoginEvent {
  late final String emailId;
  late final String password;

  LoginButtonPressed({required this.emailId, required this.password});

  @override
  List<Object> get props => [emailId, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $emailId, password: $password }';
}
