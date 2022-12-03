import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta_circles/Repositories/user_repositories.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    final UserRepository userRepository = UserRepository();
    on<AuthenticationEvent>((event, emit) async {
      if (event is AppStarted) {
        // here our sharedPreference Logic  will be handle properly
        final bool hasToken = await userRepository.hasToken();

        if (hasToken) {
          emit(AuthenticationAuthenticated());
        } else {
          emit(AuthenticationUnaunthenticated());
        }
      }
      if (event is LoggedIn) {
        emit(AuthenticationLoading());
        await userRepository.persistToken(event.token);
        emit(AuthenticationAuthenticated());
      }

      if (event is LoggedOut) {
        emit(AuthenticationLoading());
        await userRepository.deleteToken();
        emit(AuthenticationUnaunthenticated());
      }
    });
  }
}
