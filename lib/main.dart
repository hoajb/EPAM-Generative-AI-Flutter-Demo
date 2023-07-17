import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'features/authentication/presentation/login_screen.dart';
import 'features/home/ui/home_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Firebase.initializeApp();
  await dotenv.load(fileName: "assets/.env");

  if (kIsWeb || defaultTargetPlatform == TargetPlatform.macOS) {
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: dotenv.env['FB_APP_ID'] ?? "",
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
