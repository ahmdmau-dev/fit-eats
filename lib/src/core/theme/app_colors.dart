import 'package:flutter/material.dart';

/// Application color palette
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF4CAF50); // Green - Health & Fitness
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFF81C784);

  // Secondary Colors
  static const Color secondary = Color(0xFFFF9800); // Orange - Energy
  static const Color secondaryDark = Color(0xFFF57C00);
  static const Color secondaryLight = Color(0xFFFFB74D);

  // Accent Colors
  static const Color accent = Color(0xFF2196F3); // Blue - Trust
  static const Color accentDark = Color(0xFF1976D2);
  static const Color accentLight = Color(0xFF64B5F6);

  // Semantic Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Neutral Colors - Light Theme
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color dividerLight = Color(0xFFE0E0E0);

  // Neutral Colors - Dark Theme
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color dividerDark = Color(0xFF2C2C2C);

  // Nutrition Colors
  static const Color protein = Color(0xFFE91E63); // Pink
  static const Color carbs = Color(0xFFFF9800); // Orange
  static const Color fats = Color(0xFFFFC107); // Amber
  static const Color calories = Color(0xFFFF5722); // Deep Orange

  // Workout Colors
  static const Color cardio = Color(0xFF2196F3); // Blue
  static const Color strength = Color(0xFF9C27B0); // Purple
  static const Color flexibility = Color(0xFF00BCD4); // Cyan
  static const Color rest = Color(0xFF607D8B); // Blue Grey

  // Gradient Colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient successGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF81C784)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Opacity
  static const double highEmphasis = 0.87;
  static const double mediumEmphasis = 0.60;
  static const double lowEmphasis = 0.38;

  // Convenience getters (default to light theme)
  static const Color textSecondary = textSecondaryLight;
  static const Color border = dividerLight;
  static const Color disabled = Color(0xFFE0E0E0);
}
