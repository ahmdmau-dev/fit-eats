import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_plan_event.freezed.dart';

@freezed
class MealPlanEvent with _$MealPlanEvent {
  const factory MealPlanEvent.loadMealPlanByDate(DateTime date) =
      LoadMealPlanByDateEvent;

  const factory MealPlanEvent.saveMealPlan(MealPlan mealPlan) =
      SaveMealPlanEvent;

  const factory MealPlanEvent.generateMealPlan({
    required String userId,
    required DateTime date,
    required int calorieTarget,
    required List<String> dietaryPreferences,
    required List<String> allergies,
  }) = GenerateMealPlanEvent;
}
