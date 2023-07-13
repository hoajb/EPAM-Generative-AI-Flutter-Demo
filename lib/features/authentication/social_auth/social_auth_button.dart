import 'package:flutter/material.dart';

class SocialAuthButton extends StatelessWidget {
  final VoidCallback? onPressedFacebook;
  final VoidCallback? onPressedGoogle;
  final VoidCallback? onPressedTwitter;

  const SocialAuthButton({
    Key? key,
    this.onPressedFacebook,
    this.onPressedGoogle,
    this.onPressedTwitter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: onPressedFacebook,
          style: ElevatedButton.styleFrom(primary: Colors.blue[600]),
          child: const Text('Login with Facebook'),
        ),
        ElevatedButton(
          onPressed: onPressedGoogle,
          style: ElevatedButton.styleFrom(primary: Colors.red[700]),
          child: const Text('Login with Google'),
        ),
        ElevatedButton(
          onPressed: onPressedTwitter,
          style: ElevatedButton.styleFrom(primary: Colors.blue[300]),
          child: const Text('Login with Twitter'),
        ),
      ],
    );
  }
}