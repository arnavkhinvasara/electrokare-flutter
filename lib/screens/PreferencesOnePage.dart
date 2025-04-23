import 'package:flutter/material.dart';
import '../dataStructures/registrationData.dart';
import '../utils/app_styles.dart';
import '../components/preference_components.dart';

class PreferencesOnePage extends StatefulWidget {
  const PreferencesOnePage({Key? key}) : super(key: key);

  @override
  _PreferencesOnePageState createState() => _PreferencesOnePageState();
}

class _PreferencesOnePageState extends State<PreferencesOnePage> {
  final List<String> _exerciseOptions = [
    'Running',
    'Aerobic Dance',
    'Gym Training',
    'Cycling',
    'Yoga',
    'Walking',
  ];

  List<String> _selectedExercises = [];
  bool _showError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferenceScreenAppBar(progress: 0.6),
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            const SizedBox(height: 30),
            AppWidgets.titleWithSubtitle(
              'How do you normally exercise?',
              'You can change this later in the settings',
            ),
            const SizedBox(height: 30),
            Expanded(child: _buildExerciseGrid()),
            if (_showError)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Please select at least one exercise',
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AppWidgets.paginationDots(0, 3),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
              child: Center(child: _buildNextButton()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    // Selected or not selected styles
    final borderColor =
        _selectedExercises.isNotEmpty ? AppColors.primary : Colors.grey;

    return Container(
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ElevatedButton(
        onPressed: _handleNext,
        style: AppStyles.primaryButtonStyle,
        child: const Text('Next', style: AppStyles.buttonTextStyle),
      ),
    );
  }

  Widget _buildExerciseGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          childAspectRatio: 1.5,
        ),
        itemCount: _exerciseOptions.length,
        itemBuilder: (context, index) {
          final exercise = _exerciseOptions[index];
          final isSelected = _selectedExercises.contains(exercise);

          return PreferenceTile(
            title: exercise,
            image: _getImageForExercise(exercise),
            isSelected: isSelected,
            onTap: () => _toggleExerciseSelection(exercise),
          );
        },
      ),
    );
  }

  void _toggleExerciseSelection(String exercise) {
    setState(() {
      if (_selectedExercises.contains(exercise)) {
        _selectedExercises.remove(exercise);
      } else {
        _selectedExercises.add(exercise);
      }
      // Clear error message when user makes a selection
      if (_showError && _selectedExercises.isNotEmpty) {
        _showError = false;
      }
    });
  }

  void _handleNext() {
    if (_selectedExercises.isEmpty) {
      setState(() {
        _showError = true;
      });
      return;
    }

    final RegistrationData data =
        ModalRoute.of(context)!.settings.arguments as RegistrationData;

    data.exercisePreferences = _selectedExercises;

    Navigator.pushNamed(context, '/preferencesTwo', arguments: data);
  }

  Widget _getImageForExercise(String exercise) {
    switch (exercise) {
      case 'Running':
        return Image.asset('assets/images/running.png', width: 50, height: 50);
      case 'Aerobic Dance':
        return Image.asset(
          'assets/images/aerobic_dance.png',
          width: 50,
          height: 50,
        );
      case 'Gym Training':
        return Image.asset(
          'assets/images/gym_training.png',
          width: 50,
          height: 50,
        );
      case 'Cycling':
        return Image.asset('assets/images/cycling.png', width: 50, height: 50);
      case 'Yoga':
        return Image.asset('assets/images/yoga.png', width: 50, height: 50);
      case 'Walking':
        return Image.asset('assets/images/walking.png', width: 50, height: 50);
      default:
        return Image.asset('assets/images/running.png', width: 50, height: 50);
    }
  }
}
