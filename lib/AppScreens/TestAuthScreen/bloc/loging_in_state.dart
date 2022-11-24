part of 'loging_in_bloc.dart';

@immutable
abstract class LogingInState {}

class LogingInInitial extends LogingInState {}

class LogingInLoadingState extends LogingInState {}

class LogingLoadedState extends LogingInState {}

class LogingErrorState extends LogingInState {}
