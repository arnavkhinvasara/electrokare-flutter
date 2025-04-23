import 'package:flutter/material.dart';
import '../dataStructures/registrationData.dart';
import '../utils/app_styles.dart';
import '../components/preference_components.dart';

class PreferencesTwoPage extends StatefulWidget {
  const PreferencesTwoPage({Key? key}) : super(key: key);

  @override
  _PreferencesTwoPageState createState() => _PreferencesTwoPageState();
}

class _PreferencesTwoPageState extends State<PreferencesTwoPage> {
  final List<String> _exerciseOptions = [
    'Sauna',
    'Recovery',
    'Hiking',
    'Swimming',
  ];

  List<String> _selectedExercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferenceScreenAppBar(progress: 0.6),
      body: PreferenceScreenLayout(
        title: 'How do you normally exercise?',
        subtitle: 'You can change this later in the settings',
        grid: _buildExerciseGrid(),
        currentPage: 1,
        totalPages: 3,
        onNextPressed: _handleNext,
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
    });
  }

  void _handleNext() {
    final RegistrationData data =
        ModalRoute.of(context)!.settings.arguments as RegistrationData;

    if (_selectedExercises.isNotEmpty) {
      data.exercisePreferences.addAll(_selectedExercises);
    }

    Navigator.pushNamed(context, '/preferencesThree', arguments: data);
  }

  Widget _getImageForExercise(String exercise) {
    switch (exercise) {
      case 'Sauna':
        return Image.asset('assets/images/sauna.png', width: 50, height: 50);
      case 'Recovery':
        return Image.asset('assets/images/recovery.png', width: 50, height: 50);
      case 'Hiking':
        return Image.asset('assets/images/hiking.png', width: 50, height: 50);
      case 'Swimming':
        return Image.asset('assets/images/swimming.png', width: 50, height: 50);
      default:
        return Image.asset('assets/images/running.png', width: 50, height: 50);
    }
  }
}
