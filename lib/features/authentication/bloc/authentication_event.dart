abstract class AuthenticationEvent {}

class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthenticationEvent {}

class ForgotPasswordRequested extends AuthenticationEvent {}