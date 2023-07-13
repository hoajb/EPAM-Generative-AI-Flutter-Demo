import 'package:flutter/material.dart';
import 'core/service_locator.dart';
import 'features/authentication/presentation/login_screen.dart';
import 'features/home/ui/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
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
