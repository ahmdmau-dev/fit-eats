import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_plan_state.freezed.dart';

@freezed
class MealPlanState with _$MealPlanState {
  const factory MealPlanState.initial() = MealPlanInitial;

  const factory MealPlanState.loading() = MealPlanLoading;

  const factory MealPlanState.loaded(MealPlan? mealPlan) = MealPlanLoaded;

  const factory MealPlanState.generating() = MealPlanGenerating;

  const factory MealPlanState.saving() = MealPlanSaving;

  const factory MealPlanState.saved() = MealPlanSaved;

  const factory MealPlanState.error(String message) = MealPlanError;
}
