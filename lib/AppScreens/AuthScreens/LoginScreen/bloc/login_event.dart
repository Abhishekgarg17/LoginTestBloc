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
// class LoginEmailChanged extends LoginEvent {
//   final String emailId;

//   const LoginEmailChanged(required, this.emailId);
// }

// class LoginPasswordChanged extends LoginEvent {
//   final String password;

//   const LoginPasswordChanged(required, this.password);
// }

// class LoginButtonPressed extends LoginEvent {
//   late final String emailId;
//   late final String password;

//   LoginButtonPressed({required this.emailId, required this.password});

//   @override
//   List<Object> get props => [emailId, password];

//   @override
//   String toString() =>
//       'LoginButtonPressed { username: $emailId, password: $password }';
// }
