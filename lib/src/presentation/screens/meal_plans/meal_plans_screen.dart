import 'package:fiteats/src/core/theme/app_colors.dart';
import 'package:fiteats/src/core/theme/app_text_styles.dart';
import 'package:fiteats/src/presentation/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class MealPlansScreen extends StatelessWidget {
  const MealPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plans'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.restaurant_menu,
                size: 80,
                color: AppColors.primary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'No Meal Plans Yet',
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Generate your first AI-powered meal plan to get started',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Generate Meal Plan',
                onPressed: () {
                  // TODO: Navigate to meal plan generation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Meal plan generation coming soon!'),
                    ),
                  );
                },
                icon: Icons.auto_awesome,
                isFullWidth: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
