import 'package:flutter/material.dart';
import '../dataStructures/registrationData.dart';
import '../utils/app_styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();

  String? _firstNameErrorMessage;
  String? _lastNameErrorMessage;
  String? _ageErrorMessage;
  String? _weightErrorMessage;
  String? _heightErrorMessage;

  String _selectedGender = 'Select Gender';
  String _selectedUnit = 'Km';

  final List<String> _genderOptions = [
    'Select Gender',
    'Male',
    'Female',
    'Other',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
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
            AppWidgets.progressIndicator(0.4),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container for input fields
            Container(
              color: AppColors.background,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Name Field
                  const Text(
                    'First Name',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _firstNameController,
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
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 5),
                  if (_firstNameErrorMessage != null)
                    Text(
                      _firstNameErrorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 10),

                  // Last Name Field
                  const Text(
                    'Last Name',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _lastNameController,
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
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 5),
                  if (_lastNameErrorMessage != null)
                    Text(
                      _lastNameErrorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 10),

                  // Age and Gender Fields
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Age Field (left side)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Age',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _ageController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.cardBackground,
                                filled: true,
                              ),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (_ageErrorMessage != null)
                              Text(
                                _ageErrorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),
                      // Gender Dropdown (right side)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Gender',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.cardBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DropdownButton<String>(
                                value: _selectedGender,
                                isExpanded: true,
                                dropdownColor: AppColors.cardBackground,
                                underline: Container(),
                                style: TextStyle(color: AppColors.textPrimary),
                                items:
                                    _genderOptions.map((String gender) {
                                      return DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      );
                                    }).toList(),
                                onChanged: _handleGenderChange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Weight and Height Fields - Side by Side
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Weight Field (left side)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Weight (lbs)',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.cardBackground,
                                filled: true,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (_weightErrorMessage != null)
                              Text(
                                _weightErrorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Height Field (right side)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Height (ft)',
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              controller: _heightController,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 16,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                fillColor: AppColors.cardBackground,
                                filled: true,
                              ),
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: true,
                              ),
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (_heightErrorMessage != null)
                              Text(
                                _heightErrorMessage!,
                                style: TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Default Measurement Unit
                  const Text(
                    'Default Measurement Unit',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0,
                      ),
                      child: IntrinsicWidth(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Km Radio Button
                            Radio<String>(
                              value: 'Km',
                              groupValue: _selectedUnit,
                              activeColor: AppColors.primary,
                              onChanged: _handleUnitChange,
                            ),
                            Text(
                              'Km',
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                            const SizedBox(width: 20),
                            // Miles Radio Button
                            Radio<String>(
                              value: 'Miles',
                              groupValue: _selectedUnit,
                              activeColor: AppColors.primary,
                              onChanged: _handleUnitChange,
                            ),
                            Text(
                              'Miles',
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),

                  // Next Button
                  Center(
                    child: Container(
                      width: 300,
                      decoration: AppStyles.buttonContainerDecoration,
                      child: ElevatedButton(
                        onPressed: _validateAndRegister,
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

  void _handleGenderChange(String? value) {
    setState(() {
      _selectedGender = value!;
    });
  }

  void _handleUnitChange(String? value) {
    setState(() {
      _selectedUnit = value!;
    });
  }

  void _validateAndRegister() {
    setState(() {
      // Reset all error messages
      _firstNameErrorMessage = null;
      _lastNameErrorMessage = null;
      _ageErrorMessage = null;
      _weightErrorMessage = null;
      _heightErrorMessage = null;

      // Validate fields one by one

      // 1. First priority: Validate first name
      String firstName = _firstNameController.text;
      if (firstName.isEmpty) {
        _firstNameErrorMessage = 'First name cannot be empty';
        return;
      }

      // 2. Second priority: Validate last name
      String lastName = _lastNameController.text;
      if (lastName.isEmpty) {
        _lastNameErrorMessage = 'Last name cannot be empty';
        return;
      }

      // 3. Third priority: Validate age
      String age = _ageController.text;
      if (age.isEmpty) {
        _ageErrorMessage = 'Age cannot be empty';
        return;
      } else {
        try {
          int ageValue = int.parse(age);
          if (ageValue <= 0 || ageValue > 120) {
            _ageErrorMessage = 'Please enter a valid age';
            return;
          }
        } catch (e) {
          _ageErrorMessage = 'Age must be a number';
          return;
        }
      }

      // 4. Fourth priority: Validate gender
      if (_selectedGender == 'Select Gender') {
        // Show error near gender dropdown
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a gender'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // 5. Fifth priority: Validate weight
      String weight = _weightController.text;
      if (weight.isEmpty) {
        _weightErrorMessage = 'Weight cannot be empty';
        return;
      } else {
        try {
          double weightValue = double.parse(weight);
          if (weightValue <= 0) {
            _weightErrorMessage = 'Please enter a valid weight';
            return;
          }
        } catch (e) {
          _weightErrorMessage = 'Weight must be a number';
          return;
        }
      }

      // 6. Sixth priority: Validate height
      String height = _heightController.text;
      if (height.isEmpty) {
        _heightErrorMessage = 'Height cannot be empty';
        return;
      } else {
        try {
          double heightValue = double.parse(height);
          if (heightValue <= 0) {
            _heightErrorMessage = 'Please enter a valid height';
            return;
          }
        } catch (e) {
          _heightErrorMessage = 'Height must be a number';
          return;
        }
      }

      // All validations passed so navigate to preferencesOne page while building the RegistrationData object
      final RegistrationData data =
          ModalRoute.of(context)!.settings.arguments as RegistrationData;
      data.firstName = firstName;
      data.lastName = lastName;
      data.age = int.parse(age);
      data.gender = _selectedGender;
      data.weight = double.parse(weight);
      data.height = double.parse(height);
      data.defaultUnit = _selectedUnit;
      Navigator.pushNamed(context, '/preferencesOne', arguments: data);
    });
  }
}
