import 'package:fiteats/src/domain/entities/workout_exercise.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_exercise_model.freezed.dart';
part 'workout_exercise_model.g.dart';

@freezed
class WorkoutExerciseModel with _$WorkoutExerciseModel {
  const factory WorkoutExerciseModel({
    required String id,
    required String name,
    required String description,
    required ExerciseType type,
    int? sets,
    int? reps,
    int? duration,
    int? restTime,
    String? videoUrl,
    String? thumbnailUrl,
    List<String>? equipment,
    List<String>? muscleGroups,
    @Default(false) bool isCompleted,
  }) = _WorkoutExerciseModel;

  const WorkoutExerciseModel._();

  factory WorkoutExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutExerciseModelFromJson(json);

  /// Convert from entity
  factory WorkoutExerciseModel.fromEntity(WorkoutExercise entity) {
    return WorkoutExerciseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      type: entity.type,
      sets: entity.sets,
      reps: entity.reps,
      duration: entity.duration,
      restTime: entity.restTime,
      videoUrl: entity.videoUrl,
      thumbnailUrl: entity.thumbnailUrl,
      equipment: entity.equipment,
      muscleGroups: entity.muscleGroups,
      isCompleted: entity.isCompleted,
    );
  }

  /// Convert to entity
  WorkoutExercise toEntity() {
    return WorkoutExercise(
      id: id,
      name: name,
      description: description,
      type: type,
      sets: sets,
      reps: reps,
      duration: duration,
      restTime: restTime,
      videoUrl: videoUrl,
      thumbnailUrl: thumbnailUrl,
      equipment: equipment,
      muscleGroups: muscleGroups,
      isCompleted: isCompleted,
    );
  }
}
