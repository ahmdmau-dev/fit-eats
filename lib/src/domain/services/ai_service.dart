import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';

/// Abstract AI service interface
/// Implementations: OpenAI, Gemini, Claude, Mock
abstract class AIService {
  /// Generate a meal plan based on user preferences
  Future<Either<Failure, MealPlan>> generateMealPlan({
    required String userId,
    required DateTime date,
    required int calorieTarget,
    required List<String> dietaryPreferences,
    required List<String> allergies,
  });

  /// Generate a workout plan based on user preferences
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan({
    required String userId,
    required DateTime date,
    required String level,
    required String type,
    required int duration,
  });

  /// Get the name of the AI provider
  String get providerName;
}
