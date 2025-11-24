import 'package:fiteats/src/core/theme/app_colors.dart';
import 'package:fiteats/src/core/theme/app_text_styles.dart';
import 'package:fiteats/src/presentation/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';

class WorkoutsScreen extends StatelessWidget {
  const WorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Plans'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.fitness_center,
                size: 80,
                color: AppColors.secondary.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'No Workout Plans Yet',
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Generate your first AI-powered workout plan to get started',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Generate Workout',
                onPressed: () {
                  // TODO: Navigate to workout plan generation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Workout generation coming soon!'),
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
