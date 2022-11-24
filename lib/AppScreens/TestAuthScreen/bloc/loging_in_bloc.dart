import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loging_in_event.dart';
part 'loging_in_state.dart';

class LogingInBloc extends Bloc<LogingInEvent, LogingInState> {
  LogingInBloc() : super(LogingInInitial()) {
    on<LogingInEvent>((event, emit) {});
  }
}
