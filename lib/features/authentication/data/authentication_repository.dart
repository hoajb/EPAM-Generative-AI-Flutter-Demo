import 'authentication_data_source.dart';

class AuthenticationRepository {
  final AuthenticationDataSource dataSource;

  AuthenticationRepository({required this.dataSource});

  Future<String> login(String email, String password) {
    return dataSource.login(email, password);
  }

  Future<String> register(String email, String password) {
    return dataSource.register(email, password);
    throw UnimplementedError();
  }

  Future<String> forgotPassword(String email) {
    return dataSource.forgotPassword(email);
  }
}
