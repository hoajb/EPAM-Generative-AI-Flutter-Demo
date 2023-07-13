import 'package:get_it/get_it.dart';

import '../features/authentication/bloc/authentication_bloc.dart';
import '../features/authentication/data/api_client.dart';
import '../features/authentication/data/authentication_data_source.dart';
import '../features/authentication/data/authentication_repository.dart';
import '../features/authentication/domain/authentication_use_case.dart';
import '../features/authentication/social_auth/bloc/social_auth_bloc.dart';
import '../features/authentication/social_auth/repository/social_auth_repository.dart';

final GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton<ApiClient>(() => ApiClient(baseUrl: 'https://your-api-url'));
  serviceLocator.registerLazySingleton<AuthenticationDataSource>(
      () => AuthenticationRemoteDataSource(apiClient: serviceLocator<ApiClient>()));
  serviceLocator.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(dataSource: serviceLocator<AuthenticationDataSource>()));
  serviceLocator
      .registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: serviceLocator<AuthenticationRepository>()));
  serviceLocator
      .registerFactory<AuthenticationBloc>(() => AuthenticationBloc(loginUseCase: serviceLocator<LoginUseCase>()));
  serviceLocator.registerLazySingleton<SocialAuthRepository>(() => SocialAuthRepository());
  serviceLocator.registerFactory<SocialAuthBloc>(() => SocialAuthBloc(repository: serviceLocator<SocialAuthRepository>()));

}
