import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/data/models/workout_exercise_model.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_plan_model.freezed.dart';
part 'workout_plan_model.g.dart';

@freezed
class WorkoutPlanModel with _$WorkoutPlanModel {
  const factory WorkoutPlanModel({
    required String id,
    required String userId,
    required String title,
    required String description,
    required DateTime date,
    required WorkoutLevel level,
    required WorkoutType type,
    required List<WorkoutExerciseModel> exercises,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? notes,
    @Default(false) bool isCompleted,
  }) = _WorkoutPlanModel;

  const WorkoutPlanModel._();

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutPlanModelFromJson(json);

  /// Convert from entity
  factory WorkoutPlanModel.fromEntity(WorkoutPlan entity) {
    return WorkoutPlanModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      description: entity.description,
      date: entity.date,
      level: entity.level,
      type: entity.type,
      exercises: entity.exercises
          .map((e) => WorkoutExerciseModel.fromEntity(e))
          .toList(),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      notes: entity.notes,
      isCompleted: entity.isCompleted,
    );
  }

  /// Convert to entity
  WorkoutPlan toEntity() {
    return WorkoutPlan(
      id: id,
      userId: userId,
      title: title,
      description: description,
      date: date,
      level: level,
      type: type,
      exercises: exercises.map((e) => e.toEntity()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
      notes: notes,
      isCompleted: isCompleted,
    );
  }
}
