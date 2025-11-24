import 'package:fiteats/src/data/models/recipe_model.dart';
import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meal_plan_model.freezed.dart';
part 'meal_plan_model.g.dart';

@freezed
class MealPlanModel with _$MealPlanModel {
  const factory MealPlanModel({
    required String id,
    required String userId,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
    RecipeModel? breakfast,
    RecipeModel? morningSnack,
    RecipeModel? lunch,
    RecipeModel? afternoonSnack,
    RecipeModel? dinner,
    RecipeModel? eveningSnack,
    String? notes,
  }) = _MealPlanModel;

  const MealPlanModel._();

  factory MealPlanModel.fromJson(Map<String, dynamic> json) =>
      _$MealPlanModelFromJson(json);

  /// Convert from entity
  factory MealPlanModel.fromEntity(MealPlan entity) {
    return MealPlanModel(
      id: entity.id,
      userId: entity.userId,
      date: entity.date,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      breakfast: entity.breakfast != null
          ? RecipeModel.fromEntity(entity.breakfast!)
          : null,
      morningSnack: entity.morningSnack != null
          ? RecipeModel.fromEntity(entity.morningSnack!)
          : null,
      lunch: entity.lunch != null ? RecipeModel.fromEntity(entity.lunch!) : null,
      afternoonSnack: entity.afternoonSnack != null
          ? RecipeModel.fromEntity(entity.afternoonSnack!)
          : null,
      dinner:
          entity.dinner != null ? RecipeModel.fromEntity(entity.dinner!) : null,
      eveningSnack: entity.eveningSnack != null
          ? RecipeModel.fromEntity(entity.eveningSnack!)
          : null,
      notes: entity.notes,
    );
  }

  /// Convert to entity
  MealPlan toEntity() {
    return MealPlan(
      id: id,
      userId: userId,
      date: date,
      createdAt: createdAt,
      updatedAt: updatedAt,
      breakfast: breakfast?.toEntity(),
      morningSnack: morningSnack?.toEntity(),
      lunch: lunch?.toEntity(),
      afternoonSnack: afternoonSnack?.toEntity(),
      dinner: dinner?.toEntity(),
      eveningSnack: eveningSnack?.toEntity(),
      notes: notes,
    );
  }
}
