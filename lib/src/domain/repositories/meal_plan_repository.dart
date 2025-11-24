import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/meal_plan.dart';

abstract class MealPlanRepository {
  /// Get meal plan by ID
  Future<Either<Failure, MealPlan>> getMealPlan(String id);

  /// Get meal plan by date
  Future<Either<Failure, MealPlan?>> getMealPlanByDate(DateTime date);

  /// Save or update meal plan
  Future<Either<Failure, void>> saveMealPlan(MealPlan mealPlan);

  /// Delete meal plan
  Future<Either<Failure, void>> deleteMealPlan(String id);

  /// Get all meal plans for a user
  Future<Either<Failure, List<MealPlan>>> getAllMealPlans(String userId);

  /// Get meal plans for a date range
  Future<Either<Failure, List<MealPlan>>> getMealPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Generate AI-powered meal plan
  Future<Either<Failure, MealPlan>> generateMealPlan({
    required String userId,
    required DateTime date,
    required int calorieTarget,
    required List<String> dietaryPreferences,
    required List<String> allergies,
  });
}
