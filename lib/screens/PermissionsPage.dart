import 'package:flutter/material.dart';
import '../dataStructures/registrationData.dart';
import '../utils/app_styles.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({Key? key}) : super(key: key);

  @override
  _PermissionsPageState createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  // Store selected permissions in a list
  List<String> _selectedPermissions = [];

  // Available permissions
  final List<String> _availablePermissions = [
    'Polar H-10',
    'Notifications',
    'Location',
    'Movement',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Title
              const Text(
                'Allow Permissions',
                style: AppStyles.titleStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),

              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'In order to get best results, we highly recommend that you enable permissions.',
                  style: AppStyles.subtitleStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // Permission Tiles
              _buildPermissionTile('Polar H-10', 'polar.png'),
              const SizedBox(height: 15),
              _buildPermissionTile('Notifications', 'notifications.png'),
              const SizedBox(height: 15),
              _buildPermissionTile('Location', 'location.png'),
              const SizedBox(height: 15),
              _buildPermissionTile('Movement', 'movement.png'),

              const SizedBox(height: 20),

              // Continue Button
              Container(
                width: 350,
                decoration: AppStyles.buttonContainerDecoration,
                child: ElevatedButton(
                  onPressed: _handleFinish,
                  style: AppStyles.primaryButtonStyle,
                  child: const Text(
                    'Continue',
                    style: AppStyles.buttonTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleFinish() {
    final RegistrationData data =
        ModalRoute.of(context)!.settings.arguments as RegistrationData;

    // Pass selected permissions to the registration data
    data.permissions = _selectedPermissions;

    // Navigate to next page
    Navigator.pushNamed(context, '/nextSteps', arguments: data);
  }

  Widget _buildPermissionTile(String title, String imageName) {
    final bool isGranted = _selectedPermissions.contains(title);

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey[700]!, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image for each tile
          Image.asset('assets/images/$imageName', width: 20, height: 20),
          const SizedBox(height: 4),

          // Title for each tile
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),

          // Permission buttons for each tile
          isGranted
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Permission granted
                  const Text(
                    'Permission granted',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 9),

                  // Remove permission button
                  OutlinedButton(
                    onPressed: () => _togglePermission(title),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: BorderSide(color: Colors.grey[700]!, width: 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                    child: const Text(
                      'Remove Permission',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              )
              : Center(
                child: OutlinedButton(
                  onPressed: () => _togglePermission(title),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.cardBackground,
                    foregroundColor: AppColors.textPrimary,
                    side: BorderSide(color: Colors.grey[700]!, width: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'Grant Permission',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  void _togglePermission(String title) {
    setState(() {
      if (_selectedPermissions.contains(title)) {
        _selectedPermissions.remove(title);
      } else {
        _selectedPermissions.add(title);
      }
    });
  }
}
