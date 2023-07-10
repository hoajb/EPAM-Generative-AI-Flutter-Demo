import '../data/authentication_repository.dart';

abstract class AuthenticationUseCase<T, Params> {
  Future<T> call(Params params);
}

class LoginUseCase implements AuthenticationUseCase<String, LoginParams> {
  final AuthenticationRepository _repository;

  LoginUseCase({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  Future<String> call(LoginParams params) async {
    return await _repository.login(params.email, params.password);
  }
}

class RegisterUseCase implements AuthenticationUseCase<String, RegisterParams> {
  final AuthenticationRepository _repository;

  RegisterUseCase({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  Future<String> call(RegisterParams params) async {
   return await _repository.register(params.email, params.password);
  }
}

class ForgotPasswordUseCase implements AuthenticationUseCase<String, ForgotPasswordParams> {
  final AuthenticationRepository _repository;

  ForgotPasswordUseCase({required AuthenticationRepository repository})
      : _repository = repository;

  @override
  Future<String> call(ForgotPasswordParams params) async {
    return await _repository.forgotPassword(params.email);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email, required this.password});
}

class ForgotPasswordParams {
  final String email;

  ForgotPasswordParams({required this.email});
}
