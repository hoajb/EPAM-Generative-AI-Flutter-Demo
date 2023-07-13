import 'dart:developer';

import 'package:banking_demo/features/authentication/social_auth/bloc/social_auth_event.dart';
import 'package:banking_demo/features/authentication/social_auth/bloc/social_auth_state.dart';
import 'package:banking_demo/features/authentication/social_auth/repository/social_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialAuthBloc extends Bloc<SocialAuthEvent, SocialAuthState> {
  final SocialAuthRepository _repository;

  SocialAuthBloc({required SocialAuthRepository repository})
      : _repository = repository,
        super(SocialAuthInitial());

  @override
  Stream<SocialAuthState> mapEventToState(SocialAuthEvent event) async* {
    if (event is SignInWithGoogle) {
      yield SocialAuthLoading();
      try {
        UserCredential? userCredential = await _repository.signInWithGoogle();
        if (userCredential != null) {
          yield SocialAuthSuccess();
        } else {
          yield SocialAuthFailure(message: 'SignInWithGoogle failed');
        }
      } catch (e) {
        log('[SignInWithGoogle] Error: $e');
        yield SocialAuthFailure(message: e.toString());
      }
    } else if (event is SignInWithFacebook) {
      yield SocialAuthLoading();
      try {
        UserCredential? userCredential = await _repository.signInWithFacebook();
        if (userCredential != null) {
          yield SocialAuthSuccess();
        } else {
          yield SocialAuthFailure(message: 'SignInWithFacebook failed');
        }
      } catch (e) {
        log('[SignInWithFacebook] Error: $e');
        yield SocialAuthFailure(message: e.toString());
      }
    } else if (event is SignInWithTwitter) {
      yield SocialAuthLoading();
      try {
        UserCredential? userCredential = await _repository.signInWithTwitter();
        if (userCredential != null) {
          yield SocialAuthSuccess();
        } else {
          yield SocialAuthFailure(message: 'SignInWithTwitter failed');
        }
      } catch (e) {
        log('[SignInWithTwitter] Error: $e');
        yield SocialAuthFailure(message: e.toString());
      }
    }
  }
}
