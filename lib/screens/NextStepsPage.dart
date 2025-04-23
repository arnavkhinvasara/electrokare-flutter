import 'package:flutter/material.dart';
import '../dataStructures/registrationData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/auth_utils.dart';
import '../utils/app_styles.dart';

class NextStepsPage extends StatefulWidget {
  const NextStepsPage({Key? key}) : super(key: key);

  @override
  _NextStepsPageState createState() => _NextStepsPageState();
}

class _NextStepsPageState extends State<NextStepsPage> {
  bool _isLoading = true;
  bool _isError = false;
  String _errorMessage = '';
  bool _isFromRegister = false;
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    // To access context
    Future.delayed(Duration.zero, () {
      _handleNavigation();
    });
  }

  Future<void> _handleNavigation() async {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is RegistrationData) {
      // Coming from registration flow
      _isFromRegister = true;
      await _saveUserData(args);
    } else if (args is LoginData) {
      // Coming from login flow
      await _fetchUserData(args.email);
    } else {
      // Handle case when no arguments are passed
      setState(() {
        _isLoading = false;
        _isError = true;
        _errorMessage = 'Invalid navigation. Missing required data.';
      });
    }
  }

  Future<void> _saveUserData(RegistrationData data) async {
    try {
      // Connect to Firestore
      final firestore = FirebaseFirestore.instance;

      // Use email as document ID
      await firestore.collection('Users').doc(data.email).set(data.toJson());

      // Update state to show success UI
      if (mounted) {
        await AuthService().signup(email: data.email, password: data.password);
        await AuthService().login(email: data.email, password: data.password);
        setState(() {
          _isLoading = false;
          _userData = data.toJson();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  Future<void> _fetchUserData(String email) async {
    try {
      // Connect to Firestore
      final firestore = FirebaseFirestore.instance;

      // Get document using email as ID
      final docSnapshot = await firestore.collection('Users').doc(email).get();

      if (docSnapshot.exists) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _userData = docSnapshot.data();
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isError = true;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child:
            _isLoading
                ? _buildLoadingUI()
                : _isError
                ? _buildErrorUI()
                : _buildSuccessUI(),
      ),
    );
  }

  Widget _buildLoadingUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(color: AppColors.primary, strokeWidth: 5),
        SizedBox(height: 20),
        Text(
          _isFromRegister
              ? 'Creating your account...'
              : 'Loading your profile...',
          style: TextStyle(fontSize: 20, color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSuccessUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Green check
        Icon(Icons.check_circle, color: AppColors.primary, size: 100),
        const SizedBox(height: 20),
        // "All Set" text
        Text(
          'All Set',
          style: TextStyle(fontSize: 30, color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        if (_userData != null) ...[
          const SizedBox(height: 20),
          Text(
            'Email: ${_userData!['email']}',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 30),
        // Logout Button
        Container(
          width: 150,
          child: OutlinedButton(
            onPressed: _handleLogout,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: Colors.grey, width: 0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              minimumSize: const Size(100, 36),
            ),
            child: const Text('Log Out', style: TextStyle(fontSize: 14)),
          ),
        ),
      ],
    );
  }

  // Handle logout and navigation
  Future<void> _handleLogout() async {
    try {
      await AuthService().logout();
      if (mounted) {
        Navigator.pushNamed(context, '/login');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logout failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildErrorUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, color: Colors.red, size: 100),
        const SizedBox(height: 20),
        Text(
          _isFromRegister ? 'Error Creating Account' : 'Error Loading Profile',
          style: TextStyle(fontSize: 24, color: AppColors.textPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            _errorMessage,
            style: const TextStyle(fontSize: 16, color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          width: 200,
          child: ElevatedButton(
            onPressed: _handleTryAgain,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
            ),
          ),
        ),
      ],
    );
  }

  void _handleTryAgain() {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    _handleNavigation();
  }
}
