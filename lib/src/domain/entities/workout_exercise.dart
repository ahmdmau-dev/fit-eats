import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_exercise.freezed.dart';

/// Exercise type enum
enum ExerciseType {
  cardio,
  strength,
  flexibility,
  warmup,
  cooldown;

  String get label {
    switch (this) {
      case ExerciseType.cardio:
        return 'Cardio';
      case ExerciseType.strength:
        return 'Strength';
      case ExerciseType.flexibility:
        return 'Flexibility';
      case ExerciseType.warmup:
        return 'Warm Up';
      case ExerciseType.cooldown:
        return 'Cool Down';
    }
  }
}

/// Workout exercise entity
@freezed
class WorkoutExercise with _$WorkoutExercise {
  const factory WorkoutExercise({
    required String id,
    required String name,
    required String description,
    required ExerciseType type,
    int? sets,
    int? reps,
    int? duration, // seconds
    int? restTime, // seconds between sets
    String? videoUrl,
    String? thumbnailUrl,
    List<String>? equipment,
    List<String>? muscleGroups,
    @Default(false) bool isCompleted,
  }) = _WorkoutExercise;

  const WorkoutExercise._();

  /// Check if exercise is time-based
  bool get isTimeBased => duration != null;

  /// Check if exercise is rep-based
  bool get isRepBased => sets != null && reps != null;

  /// Total time in seconds (including rest)
  int get totalTime {
    if (isTimeBased) {
      final exerciseTime = duration! * (sets ?? 1);
      final rest = restTime ?? 0;
      final totalRest = rest * ((sets ?? 1) - 1);
      return exerciseTime + totalRest;
    }
    return 0;
  }

  /// Estimated calories burned (rough estimate)
  double get estimatedCalories {
    if (isTimeBased) {
      // Rough estimate: 5 calories per minute for cardio
      return (duration! / 60) * 5 * (sets ?? 1);
    }
    return 0;
  }
}
