import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF72BC28);
  static const Color background = Color(0xFF07111C);
  //static const Color cardBackground = Color(0xFF212121);
  static const Color cardBackground = Color(0xFF191919);
  static const Color borderColor = Color(0xFF333333);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.grey;
}

class AppStyles {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 20,
    color: AppColors.textPrimary,
  );

  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle tileTextStyle = TextStyle(
    color: AppColors.textPrimary,
    fontSize: 14,
  );

  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 11),
    backgroundColor: AppColors.background,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 0,
  );

  static BoxDecoration buttonContainerDecoration = BoxDecoration(
    border: Border.all(color: AppColors.primary, width: 2),
    borderRadius: BorderRadius.circular(20),
  );

  static BoxDecoration selectedTileDecoration = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: AppColors.primary, width: 0.5),
  );

  static BoxDecoration unselectedTileDecoration = BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey, width: 0.5),
  );
}

class AppWidgets {
  static Widget progressIndicator(double value) {
    return Container(
      width: 200,
      height: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: Colors.grey[800],
          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }

  static Widget paginationDots(int currentPage, int totalPages) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color:
                  currentPage == index
                      ? AppColors.textPrimary
                      : Colors.grey[600],
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  static Widget nextButton(VoidCallback onPressed) {
    return Container(
      width: 300,
      decoration: AppStyles.buttonContainerDecoration,
      child: ElevatedButton(
        onPressed: onPressed,
        style: AppStyles.primaryButtonStyle,
        child: const Text('Next', style: AppStyles.buttonTextStyle),
      ),
    );
  }

  static Widget titleWithSubtitle(String title, String subtitle) {
    return Column(
      children: [
        Text(title, style: AppStyles.titleStyle, textAlign: TextAlign.center),
        const SizedBox(height: 5),
        Text(
          subtitle,
          style: AppStyles.subtitleStyle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
