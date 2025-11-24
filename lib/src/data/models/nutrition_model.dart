import 'package:fiteats/src/domain/entities/nutrition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'nutrition_model.freezed.dart';
part 'nutrition_model.g.dart';

@freezed
class NutritionModel with _$NutritionModel {
  const factory NutritionModel({
    required double calories,
    required double protein,
    required double carbs,
    required double fats,
    @Default(0) double fiber,
    @Default(0) double sugar,
    @Default(0) double sodium,
  }) = _NutritionModel;

  const NutritionModel._();

  factory NutritionModel.fromJson(Map<String, dynamic> json) =>
      _$NutritionModelFromJson(json);

  /// Convert from entity
  factory NutritionModel.fromEntity(Nutrition entity) {
    return NutritionModel(
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fats: entity.fats,
      fiber: entity.fiber,
      sugar: entity.sugar,
      sodium: entity.sodium,
    );
  }

  /// Convert to entity
  Nutrition toEntity() {
    return Nutrition(
      calories: calories,
      protein: protein,
      carbs: carbs,
      fats: fats,
      fiber: fiber,
      sugar: sugar,
      sodium: sodium,
    );
  }
}
