import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:banking_demo/features/authentication/bloc/authentication_bloc.dart';
import 'package:banking_demo/features/authentication/bloc/authentication_event.dart';
import 'package:banking_demo/features/authentication/bloc/authentication_state.dart';

import '../../../core/service_locator.dart';
import '../social_auth/bloc/social_auth_bloc.dart';
import '../social_auth/bloc/social_auth_event.dart';
import '../social_auth/bloc/social_auth_state.dart';
import '../social_auth/social_auth_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  static Widget create(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthenticationBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<SocialAuthBloc>(),
        ),
      ],
      child: LoginScreen(),
    );
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is AuthenticationFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
              BlocListener<SocialAuthBloc, SocialAuthState>(
                listener: (context, state) {
                  if (state is SocialAuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
              ),
            ],
            child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, stateForm) {
                if (stateForm is AuthenticationInProgress) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (stateForm is AuthenticationSuccess) {
                  // Navigate to the next screen or show a message on successful login
                  Navigator.pushNamed(context, '/home');
                }

                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: Image.asset('assets/images/logo.png'), // Replace with your logo image
                      ),
                      SizedBox(height: 24.0),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 16.0),
                      // BlocBuilder<SocialAuthBloc, SocialAuthState>(
                      //   builder: (context, socialAuthState) {
                      //     return ElevatedButton(
                      //       onPressed:
                      //       socialAuthState is! SocialAuthLoading
                      //           ? () {
                      //         BlocProvider.of<AuthenticationBloc>(
                      //             context)
                      //             .add(
                      //           LoginRequested(
                      //             email: _usernameController.text,
                      //             password: _passwordController.text,
                      //           ),
                      //         );
                      //       }
                      //           : null,
                      //       child: Text('Login'),
                      //     );
                      //   },
                      // ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<AuthenticationBloc>(context).add(
                            LoginRequested(
                              email: _usernameController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                        child: Text('Login'),
                      ),
                      SizedBox(height: 16.0),
                      SocialAuthButton(
                        onPressedGoogle: () => BlocProvider.of<SocialAuthBloc>(context).add(SignInWithGoogle()),
                        onPressedFacebook: () => BlocProvider.of<SocialAuthBloc>(context).add(SignInWithFacebook()),
                        onPressedTwitter: () => BlocProvider.of<SocialAuthBloc>(context).add(SignInWithTwitter()),
                      ),
                    ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
