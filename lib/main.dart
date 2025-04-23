import 'package:flutter/material.dart';
import 'screens/SplashScreen.dart';
import 'screens/LoginPage.dart';
import 'screens/SignUpPage.dart';
import 'screens/RegisterPage.dart';
import 'screens/PreferencesOnePage.dart';
import 'screens/PreferencesTwoPage.dart';
import 'screens/PreferencesThreePage.dart';
import 'screens/NextStepsPage.dart';
import 'screens/PermissionsPage.dart';
import 'screens/ForgotPasswordPage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'electrokare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFF07111C),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/register': (context) => const RegisterPage(),
        '/preferencesOne': (context) => const PreferencesOnePage(),
        '/preferencesTwo': (context) => const PreferencesTwoPage(),
        '/preferencesThree': (context) => const PreferencesThreePage(),
        '/nextSteps': (context) => const NextStepsPage(),
        '/permissions': (context) => const PermissionsPage(),
        '/forgotPassword': (context) => const ForgotPasswordPage(),
      },
    );
  }
}
