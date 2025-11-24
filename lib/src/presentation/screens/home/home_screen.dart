import 'package:fiteats/src/core/theme/app_colors.dart';
import 'package:fiteats/src/core/theme/app_text_styles.dart';
import 'package:fiteats/src/presentation/widgets/common/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitEats AI'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: AppTextStyles.headlineSmall.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Ready to crush your fitness goals today?',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Today's Overview
            Text('Today\'s Overview', style: AppTextStyles.titleLarge),
            const SizedBox(height: 16),
            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Calories',
                    value: '0',
                    subtitle: '/ 2000 kcal',
                    icon: Icons.local_fire_department,
                    color: AppColors.calories,
                    onTap: () {
                      context.go('/meal-plans');
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: StatCard(
                    title: 'Workouts',
                    value: '0',
                    subtitle: 'completed',
                    icon: Icons.fitness_center,
                    color: AppColors.strength,
                    onTap: () {
                      context.go('/workouts');
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Quick Actions
            Text('Quick Actions', style: AppTextStyles.titleLarge),
            const SizedBox(height: 16),
            _QuickActionCard(
              title: 'Generate Meal Plan',
              subtitle: 'AI-powered meal suggestions for today',
              icon: Icons.restaurant_menu,
              color: AppColors.primary,
              onTap: () {
                context.go('/meal-plans');
              },
            ),
            const SizedBox(height: 12),
            _QuickActionCard(
              title: 'Generate Workout',
              subtitle: 'Get a personalized workout routine',
              icon: Icons.fitness_center,
              color: AppColors.secondary,
              onTap: () {
                context.go('/workouts');
              },
            ),
            const SizedBox(height: 12),
            _QuickActionCard(
              title: 'Shopping List',
              subtitle: 'View and manage your grocery list',
              icon: Icons.shopping_cart,
              color: AppColors.accent,
              onTap: () {
                context.go('/shopping-list');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTextStyles.titleMedium),
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
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
