abstract class SocialAuthState {}

class SocialAuthInitial extends SocialAuthState {}

class SocialAuthLoading extends SocialAuthState {}

class SocialAuthFailure extends SocialAuthState {
  final String message;

  SocialAuthFailure({required this.message});
}

class SocialAuthSuccess extends SocialAuthState {}