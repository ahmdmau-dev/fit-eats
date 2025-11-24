import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';

abstract class WorkoutPlanRepository {
  /// Get workout plan by ID
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlan(String id);

  /// Get workout plan by date
  Future<Either<Failure, WorkoutPlan?>> getWorkoutPlanByDate(DateTime date);

  /// Save or update workout plan
  Future<Either<Failure, void>> saveWorkoutPlan(WorkoutPlan workoutPlan);

  /// Delete workout plan
  Future<Either<Failure, void>> deleteWorkoutPlan(String id);

  /// Get all workout plans for a user
  Future<Either<Failure, List<WorkoutPlan>>> getAllWorkoutPlans(String userId);

  /// Get workout plans for a date range
  Future<Either<Failure, List<WorkoutPlan>>> getWorkoutPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  );

  /// Get completed workout plans
  Future<Either<Failure, List<WorkoutPlan>>> getCompletedWorkoutPlans(
    String userId,
  );

  /// Toggle workout plan completion status
  Future<Either<Failure, void>> toggleCompletion(String id);

  /// Generate AI-powered workout plan
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan({
    required String userId,
    required DateTime date,
    required WorkoutLevel level,
    required WorkoutType type,
    required int duration,
  });
}
