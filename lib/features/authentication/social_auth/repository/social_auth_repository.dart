import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:twitter_login/twitter_login.dart';

class SocialAuthRepository {
  Future<UserCredential?> signInWithGoogle() async {
    // Initialize GoogleSignIn
    final GoogleSignIn googleSignIn = GoogleSignIn();

    // Perform sign in with Google
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) return null;

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Perform sign in with Facebook
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // Create a new credential
      final OAuthCredential credential =
      FacebookAuthProvider.credential(result.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }

  Future<UserCredential?> signInWithTwitter() async {
    final twitterLogin = TwitterLogin(
      apiKey: 'SHNiNFFrSTdNTEZZdTFKODlfWko6MTpjaQ',
      apiSecretKey: 'Ce9CGt3CEjWjjznk26bRXEQ6NAmv87smpvzPSihKfKIfQgVkfk',
      redirectURI: 'your_twitter_callback_url',
    );

    final authResult = await twitterLogin.login();

    if (authResult.status == TwitterLoginStatus.loggedIn) {
      final OAuthCredential credential = TwitterAuthProvider.credential(
        accessToken: authResult.authToken!,
        secret: authResult.authTokenSecret!,
      );

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  }
}