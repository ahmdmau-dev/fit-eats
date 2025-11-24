import 'package:fiteats/src/core/theme/app_colors.dart';
import 'package:fiteats/src/core/theme/app_text_styles.dart';
import 'package:fiteats/src/presentation/widgets/common/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    required this.message,
    super.key,
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.circleAlert,
              size: 64,
              color: AppColors.error.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: AppTextStyles.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Try Again',
                onPressed: onRetry,
                isFullWidth: false,
                icon: LucideIcons.refreshCw,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
