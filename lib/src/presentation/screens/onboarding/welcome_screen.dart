import 'package:fiteats/src/core/theme/app_colors.dart';
import 'package:fiteats/src/core/theme/app_text_styles.dart';
import 'package:fiteats/src/presentation/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // App Icon/Logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.fitness_center,
                  size: 60,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 32),
              // Welcome Text
              Text(
                'Welcome to FitEats AI',
                style: AppTextStyles.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'Your personal AI-powered meal and workout planner',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              // Features List
              _FeatureTile(
                icon: Icons.restaurant_menu,
                title: 'Smart Meal Plans',
                subtitle: 'AI-generated meal plans tailored to your goals',
              ),
              const SizedBox(height: 16),
              _FeatureTile(
                icon: Icons.fitness_center,
                title: 'Custom Workouts',
                subtitle: 'Personalized workout routines for your level',
              ),
              const SizedBox(height: 16),
              _FeatureTile(
                icon: Icons.shopping_cart,
                title: 'Shopping Lists',
                subtitle: 'Auto-generated grocery lists from your meals',
              ),
              const Spacer(),
              // Get Started Button
              PrimaryButton(
                text: 'Get Started',
                onPressed: () {
                  context.go('/home');
                },
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: 16),
              Text(
                'No sign-up required • Free to use',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  const _FeatureTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
