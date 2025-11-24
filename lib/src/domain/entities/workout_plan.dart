import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/domain/entities/workout_exercise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_plan.freezed.dart';

/// Workout plan entity
@freezed
class WorkoutPlan with _$WorkoutPlan {
  const factory WorkoutPlan({
    required String id,
    required String userId,
    required String title,
    required String description,
    required DateTime date,
    required WorkoutLevel level,
    required WorkoutType type,
    required List<WorkoutExercise> exercises,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? notes,
    @Default(false) bool isCompleted,
  }) = _WorkoutPlan;

  const WorkoutPlan._();

  /// Total duration in seconds
  int get totalDuration {
    return exercises.fold(0, (sum, exercise) => sum + exercise.totalTime);
  }

  /// Total duration in minutes
  int get totalDurationMinutes => (totalDuration / 60).ceil();

  /// Total estimated calories
  double get totalEstimatedCalories {
    return exercises.fold(
      0,
      (sum, exercise) => sum + exercise.estimatedCalories,
    );
  }

  /// Number of completed exercises
  int get completedExercisesCount {
    return exercises.where((e) => e.isCompleted).length;
  }

  /// Completion percentage
  double get completionPercentage {
    if (exercises.isEmpty) return 0;
    return (completedExercisesCount / exercises.length) * 100;
  }

  /// Check if all exercises are completed
  bool get isFullyCompleted => exercises.every((e) => e.isCompleted);

  /// Get exercises by type
  List<WorkoutExercise> getExercisesByType(ExerciseType type) {
    return exercises.where((e) => e.type == type).toList();
  }
}
