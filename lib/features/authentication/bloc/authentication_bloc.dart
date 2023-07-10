import 'package:flutter_bloc/flutter_bloc.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import '../domain/authentication_use_case.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase _loginUseCase;

  AuthenticationBloc({required LoginUseCase loginUseCase})
      : _loginUseCase = loginUseCase,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is LoginRequested) {
      yield AuthenticationInProgress();
      try {
        final token = await _loginUseCase(LoginParams(
          email: event.email,
          password: event.password,
        ));
        yield AuthenticationSuccess(token: token);
      } catch (error) {
        yield AuthenticationFailure(message: error.toString());
      }
    }
  }
}
