import 'package:flutter/material.dart';
import 'dart:async';
import '../dataStructures/registrationData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    // Add a slight delay for splash screen visibility
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        final rememberMe = prefs.getBool("rememberMe") ?? false;

        if (rememberMe) {
          // User is signed in
          Navigator.pushNamed(
            context,
            '/nextSteps',
            arguments: LoginData(
              email: user.email ?? '',
              password: '', // We don't store or pass the password
            ),
          );
        } else {
          Navigator.pushNamed(context, '/login');
        }
      } else {
        Navigator.pushNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/electrokare_logo.png',
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 16),
            const Text(
              'electrokare',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
