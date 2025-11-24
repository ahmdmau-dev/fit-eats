import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_plan_event.freezed.dart';

@freezed
class WorkoutPlanEvent with _$WorkoutPlanEvent {
  const factory WorkoutPlanEvent.loadWorkoutPlanByDate(DateTime date) =
      LoadWorkoutPlanByDateEvent;

  const factory WorkoutPlanEvent.saveWorkoutPlan(WorkoutPlan workoutPlan) =
      SaveWorkoutPlanEvent;

  const factory WorkoutPlanEvent.toggleCompletion(String workoutPlanId) =
      ToggleCompletionEvent;

  const factory WorkoutPlanEvent.generateWorkoutPlan({
    required String userId,
    required DateTime date,
    required String level,
    required String type,
    required int duration,
  }) = GenerateWorkoutPlanEvent;
}
