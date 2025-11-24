import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition.freezed.dart';

/// Nutritional information for a recipe or meal
@freezed
class Nutrition with _$Nutrition {
  const factory Nutrition({
    required double calories,
    required double protein, // grams
    required double carbs, // grams
    required double fats, // grams
    @Default(0) double fiber, // grams
    @Default(0) double sugar, // grams
    @Default(0) double sodium, // mg
  }) = _Nutrition;

  const Nutrition._();

  /// Calculate total macros in grams
  double get totalMacros => protein + carbs + fats;

  /// Calculate percentage of protein
  double get proteinPercentage => (protein * 4 / calories) * 100;

  /// Calculate percentage of carbs
  double get carbsPercentage => (carbs * 4 / calories) * 100;

  /// Calculate percentage of fats
  double get fatsPercentage => (fats * 9 / calories) * 100;
}
