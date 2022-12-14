part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginingEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginingEvent({required this.email, required this.password});
}


