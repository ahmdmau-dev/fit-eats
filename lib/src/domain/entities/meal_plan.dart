import 'package:fiteats/src/domain/entities/recipe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_plan.freezed.dart';

/// Daily meal plan entity
@freezed
class MealPlan with _$MealPlan {
  const factory MealPlan({
    required String id,
    required String userId,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
    Recipe? breakfast,
    Recipe? morningSnack,
    Recipe? lunch,
    Recipe? afternoonSnack,
    Recipe? dinner,
    Recipe? eveningSnack,
    String? notes,
  }) = _MealPlan;

  const MealPlan._();

  /// Get all meals as a list
  List<Recipe> get allMeals {
    final meals = <Recipe>[];
    if (breakfast != null) meals.add(breakfast!);
    if (morningSnack != null) meals.add(morningSnack!);
    if (lunch != null) meals.add(lunch!);
    if (afternoonSnack != null) meals.add(afternoonSnack!);
    if (dinner != null) meals.add(dinner!);
    if (eveningSnack != null) meals.add(eveningSnack!);
    return meals;
  }

  /// Total calories for the day
  double get totalCalories {
    return allMeals.fold(0, (sum, meal) => sum + meal.nutrition.calories);
  }

  /// Total protein for the day
  double get totalProtein {
    return allMeals.fold(0, (sum, meal) => sum + meal.nutrition.protein);
  }

  /// Total carbs for the day
  double get totalCarbs {
    return allMeals.fold(0, (sum, meal) => sum + meal.nutrition.carbs);
  }

  /// Total fats for the day
  double get totalFats {
    return allMeals.fold(0, (sum, meal) => sum + meal.nutrition.fats);
  }

  /// Check if meal plan is complete
  bool get isComplete => breakfast != null && lunch != null && dinner != null;

  /// Number of meals planned
  int get mealCount => allMeals.length;
}
