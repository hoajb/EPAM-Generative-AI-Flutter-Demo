import 'api_client.dart';

abstract class AuthenticationDataSource {
  Future<String> login(String email, String password);
  Future<String> register(String email, String password);
  Future<String> forgotPassword(String email);
}

class AuthenticationRemoteDataSource implements AuthenticationDataSource {
  final ApiClient _apiClient;

  AuthenticationRemoteDataSource({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<String> login(String email, String password) async {
    return await _apiClient.login(email, password);
  }

  @override
  Future<String> register(String email, String password) async {
    return await _apiClient.register(email, password);
  }

  @override
  Future<String> forgotPassword(String email) async {
    await _apiClient.forgotPassword(email);
    return 'Password reset email sent';
  }
}