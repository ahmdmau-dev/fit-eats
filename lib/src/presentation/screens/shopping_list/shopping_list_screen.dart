import 'package:fiteats/src/core/theme/app_colors.dart';
import 'package:fiteats/src/core/theme/app_text_styles.dart';
import 'package:fiteats/src/presentation/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.shoppingCart,
                size: 80,
                color: AppColors.accent.withOpacity(0.5),
              ),
              const SizedBox(height: 24),
              Text(
                'Shopping List Empty',
                style: AppTextStyles.headlineMedium,
              ),
              const SizedBox(height: 12),
              Text(
                'Add items manually or generate a meal plan to auto-populate your shopping list',
                style: AppTextStyles.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Add Item',
                onPressed: () {
                  // TODO: Show add item dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Add item feature coming soon!'),
                    ),
                  );
                },
                icon: LucideIcons.plus,
                isFullWidth: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
