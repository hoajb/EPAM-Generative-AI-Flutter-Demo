import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'features/authentication/presentation/login_screen.dart';
import 'features/home/ui/home_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();

  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: '1814794655608925',
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banking Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen.create(context),
      routes: {
        '/home': (BuildContext context) => HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => LoginScreen.create(context));
        }
        return MaterialPageRoute(builder: (context) => HomeScreen());
      },
    );
  }
}
