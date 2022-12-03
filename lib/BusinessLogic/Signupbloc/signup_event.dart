part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonOnpressedEvent extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  const SignupButtonOnpressedEvent(
      {required this.email,
      required this.name,
      required this.password,
      required this.phone});
}
