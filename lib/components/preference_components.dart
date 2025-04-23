import 'package:flutter/material.dart';
import '../utils/app_styles.dart';

class PreferenceTile extends StatelessWidget {
  final String title;
  final Widget image;
  final bool isSelected;
  final VoidCallback onTap;

  const PreferenceTile({
    Key? key,
    required this.title,
    required this.image,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:
            isSelected
                ? AppStyles.selectedTileDecoration
                : AppStyles.unselectedTileDecoration,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              const SizedBox(height: 3),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PreferenceScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final double progress;

  const PreferenceScreenAppBar({Key? key, required this.progress})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [AppWidgets.progressIndicator(progress)],
      ),
      centerTitle: true,
      backgroundColor: AppColors.background,
      iconTheme: const IconThemeData(color: AppColors.textPrimary),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class PreferenceScreenLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget grid;
  final int currentPage;
  final int totalPages;
  final VoidCallback onNextPressed;
  final String? errorMessage;

  const PreferenceScreenLayout({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.grid,
    required this.currentPage,
    required this.totalPages,
    required this.onNextPressed,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Column(
        children: [
          const SizedBox(height: 30),
          AppWidgets.titleWithSubtitle(title, subtitle),
          const SizedBox(height: 30),
          Expanded(child: grid),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 14),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: AppWidgets.paginationDots(currentPage, totalPages),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            child: Center(child: AppWidgets.nextButton(onNextPressed)),
          ),
        ],
      ),
    );
  }
}
