import 'package:flutter/material.dart';
//import 'dart:async';
import '../utils/auth_utils.dart';
import '../dataStructures/registrationData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Logo
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Image.asset(
                        'assets/images/electrokare_logo.png',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'electrokare',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // Login Text
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 31,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Container for input fields regarding login
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF212121),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Email Label
                    const Text(
                      'Email',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Email Field
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 8),
                    if (_emailErrorMessage != null)
                      Text(
                        _emailErrorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 16),

                    // Password Label
                    const Text(
                      'Password',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Password Field
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 7,
                                horizontal: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  bottomLeft: Radius.circular(12),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.white,
                              filled: true,
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        Container(
                          height: 37,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            ),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                              size: 15,
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (_passwordErrorMessage != null)
                      Text(
                        _passwordErrorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 10),

                    // Remember Me and Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Remember Me Checkbox
                        Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: _rememberMe,
                                onChanged: _handleRememberMeChanged,
                                fillColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                checkColor: Colors.white,
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Remember me',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),

                        // Forgot Password Link
                        TextButton(
                          onPressed: _navigateToForgotPassword,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(10, 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Forgot Password ?',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),

                    // Sign in Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: AppColors.borderColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                        ),
                        child:
                            _isLoading
                                ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                                : const Text(
                                  'Sign in',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Don't have an account? Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                        TextButton(
                          onPressed: _navigateToSignUp,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.only(left: 4),
                            minimumSize: const Size(10, 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Signup',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _handleRememberMeChanged(bool? value) {
    setState(() {
      _rememberMe = value ?? false;
    });
  }

  void _navigateToForgotPassword() {
    Navigator.pushNamed(context, '/forgotPassword');
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  // Method to handle the sign-in button click
  Future<void> _handleSignIn() async {
    // First validate the email
    if (!_validateEmail()) {
      return;
    }

    // Email is valid, try to sign in
    try {
      setState(() {
        _isLoading = true;
        _passwordErrorMessage = null;
      });

      final String email = _emailController.text.trim();
      final String password = _passwordController.text;

      // Attempt to sign in with the provided credentials
      final String message = await AuthService().login(
        email: email.trim(),
        password: password.trim(),
      );

      if (message == 'Login successful') {
        // Navigate to the home screen or dashboard

        await savePreferences();

        if (mounted) {
          Navigator.pushNamed(
            context,
            '/nextSteps',
            arguments: LoginData(
              email: email.trim(),
              password: password.trim(),
            ),
          );
        }
      } else if (message == 'Login credentials are incorrect') {
        // Handle authentication failure
        setState(() {
          _passwordErrorMessage = 'Login credentials are incorrect';
        });
      }
    } catch (e) {
      // Handle exceptions
      _passwordErrorMessage = 'An error occurred';
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Method to validate the email format
  bool _validateEmail() {
    final String email = _emailController.text.trim();

    setState(() {
      _emailErrorMessage = null;
      _passwordErrorMessage = null;
    });

    if (email.isEmpty) {
      setState(() {
        _emailErrorMessage = 'Email cannot be empty';
      });
      return false;
    }

    final bool isValidEmail = RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email);

    if (!isValidEmail) {
      setState(() {
        _emailErrorMessage = 'Please enter a valid email address';
      });
      return false;
    }

    return true;
  }

  // Save user preferences
  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', _rememberMe);
  }
}
