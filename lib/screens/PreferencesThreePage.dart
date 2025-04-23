import 'package:flutter/material.dart';
import '../dataStructures/registrationData.dart';
import '../utils/app_styles.dart';
import '../components/preference_components.dart';

class PreferencesThreePage extends StatefulWidget {
  const PreferencesThreePage({Key? key}) : super(key: key);

  @override
  _PreferencesThreePageState createState() => _PreferencesThreePageState();
}

class _PreferencesThreePageState extends State<PreferencesThreePage> {
  final List<String> _drinkOptions = [
    'Gatorade',
    'NuuN',
    'Liquid IV',
    'LMNT',
    'Powerade',
    'Propel',
    'Gatorlyte',
  ];

  String? _selectedDrink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferenceScreenAppBar(progress: 1.0),
      body: PreferenceScreenLayout(
        title: 'What do you drink when you exercise?',
        subtitle: 'You can change this later in the settings',
        grid: _buildDrinkGrid(),
        currentPage: 2,
        totalPages: 3,
        onNextPressed: _handleNext,
      ),
    );
  }

  Widget _buildDrinkGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 55,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: _drinkOptions.length,
        itemBuilder: (context, index) {
          final drink = _drinkOptions[index];
          final isSelected = _selectedDrink == drink;

          return PreferenceTile(
            title: drink,
            image: _getImageForDrink(),
            isSelected: isSelected,
            onTap: () => _toggleDrinkSelection(drink),
          );
        },
      ),
    );
  }

  void _toggleDrinkSelection(String drink) {
    setState(() {
      _selectedDrink = _selectedDrink == drink ? null : drink;
    });
  }

  void _handleNext() {
    final RegistrationData data =
        ModalRoute.of(context)!.settings.arguments as RegistrationData;

    if (_selectedDrink != null) {
      data.drinkPreference = _selectedDrink!;
    }

    Navigator.pushNamed(context, '/permissions', arguments: data);
  }

  Widget _getImageForDrink() {
    return Image.asset('assets/images/bottle.png', width: 50, height: 50);
  }
}
