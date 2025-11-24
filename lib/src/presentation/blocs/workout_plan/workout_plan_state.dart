import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_plan_state.freezed.dart';

@freezed
class WorkoutPlanState with _$WorkoutPlanState {
  const factory WorkoutPlanState.initial() = WorkoutPlanInitial;

  const factory WorkoutPlanState.loading() = WorkoutPlanLoading;

  const factory WorkoutPlanState.loaded(WorkoutPlan? workoutPlan) =
      WorkoutPlanLoaded;

  const factory WorkoutPlanState.generating() = WorkoutPlanGenerating;

  const factory WorkoutPlanState.saving() = WorkoutPlanSaving;

  const factory WorkoutPlanState.saved() = WorkoutPlanSaved;

  const factory WorkoutPlanState.error(String message) = WorkoutPlanError;
}
