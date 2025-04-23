import 'package:flutter/material.dart';
import '../dataStructures/registrationData.dart';
import '../utils/auth_utils.dart';
import '../utils/app_styles.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  String? _confirmPasswordErrorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Progress indicator
            AppWidgets.progressIndicator(0.2),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),

            // Your Account Text
            const Text(
              'Create Your Account',
              style: AppStyles.titleStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),

            // Already have an account? Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account?',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 14),
                ),
                TextButton(
                  onPressed: _navigateToLogin,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(left: 4),
                    minimumSize: const Size(10, 10),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Container for input fields
            Container(
              color: AppColors.background,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email Field
                  const Text(
                    'Email',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: AppColors.cardBackground,
                      filled: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  if (_emailErrorMessage != null)
                    Text(
                      _emailErrorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 16),

                  // Password Field
                  const Text(
                    'Password',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: AppColors.cardBackground,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                          size: 18,
                        ),
                        onPressed: () => _togglePasswordVisibility(true),
                      ),
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 8),
                  if (_passwordErrorMessage != null)
                    Text(
                      _passwordErrorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 16),

                  // Confirm Password Field
                  const Text(
                    'Re-enter Password',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: AppColors.cardBackground,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                          size: 18,
                        ),
                        onPressed: () => _togglePasswordVisibility(false),
                      ),
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),

                  const SizedBox(height: 8),

                  if (_confirmPasswordErrorMessage != null)
                    Text(
                      _confirmPasswordErrorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),

                  const SizedBox(height: 150),

                  // Sign Up Button
                  Center(
                    child: Container(
                      width: 300,
                      decoration: AppStyles.buttonContainerDecoration,
                      child: ElevatedButton(
                        onPressed: _validateAndCreateAccount,
                        style: AppStyles.primaryButtonStyle,
                        child: const Text(
                          'Next',
                          style: AppStyles.buttonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.pop(context);
  }

  void _togglePasswordVisibility(bool isMainPassword) {
    setState(() {
      if (isMainPassword) {
        _obscurePassword = !_obscurePassword;
      } else {
        _obscureConfirmPassword = !_obscureConfirmPassword;
      }
    });
  }

  Future<void> _validateAndCreateAccount() async {
    // Reset all error messages
    setState(() {
      _emailErrorMessage = null;
      _passwordErrorMessage = null;
      _confirmPasswordErrorMessage = null;
    });

    // Validate fields one by one, displaying only the first error encountered

    // 1. First priority: Validate email
    String email = _emailController.text;
    if (email.isEmpty) {
      setState(() {
        _emailErrorMessage = 'Email cannot be empty';
      });
      return;
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      setState(() {
        _emailErrorMessage = 'Please enter a valid email address';
      });
      return;
    }

    // 2. Second priority: Validate password
    String password = _passwordController.text;
    if (password.isEmpty) {
      setState(() {
        _passwordErrorMessage = 'Password cannot be empty';
      });
      return;
    } else if (password.length < 6) {
      setState(() {
        _passwordErrorMessage = 'Password must be at least 6 characters';
      });
      return;
    }

    // 3. Third priority: Validate confirm password
    String confirmPassword = _confirmPasswordController.text;
    if (confirmPassword.isEmpty) {
      setState(() {
        _confirmPasswordErrorMessage = 'Please confirm your password';
      });
      return;
    } else if (confirmPassword != password) {
      setState(() {
        _confirmPasswordErrorMessage = 'Passwords do not match';
      });
      return;
    }

    // 4. Fourth priority: Make sure email is not already in use
    final message = await AuthService().signup(
      email: email.trim(),
      password: password.trim(),
    );
    if (message == 'Email already in use') {
      setState(() {
        _emailErrorMessage = 'Email already in use';
      });
      return;
    }

    // 5. Fifth priority: Ensure that this page doesn't already sign the user up
    final message2 = await AuthService().login(
      email: email.trim(),
      password: password.trim(),
    );

    if (message2 == 'Login successful') {
      await AuthService().deleteAccount();
    }

    // All validations passed, proceed to next screen
    final data = RegistrationData();
    data.email = email.trim();
    data.password = password.trim();

    Navigator.pushNamed(context, '/register', arguments: data);
  }
}
