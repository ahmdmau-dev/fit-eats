import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/domain/entities/nutrition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe.freezed.dart';

/// Recipe entity
@freezed
class Recipe with _$Recipe {
  const factory Recipe({
    required String id,
    required String title,
    required String description,
    required List<String> ingredients,
    required List<String> instructions,
    required Nutrition nutrition,
    required MealTime mealTime,
    required int prepTime, // minutes
    required int cookTime, // minutes
    required int servings,
    String? imageUrl,
    List<String>? tags,
    @Default(false) bool isFavorite,
  }) = _Recipe;

  const Recipe._();

  /// Total time in minutes
  int get totalTime => prepTime + cookTime;

  /// Calories per serving
  double get caloriesPerServing => nutrition.calories / servings;
}
