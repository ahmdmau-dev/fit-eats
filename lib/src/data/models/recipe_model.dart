import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/data/models/nutrition_model.dart';
import 'package:fiteats/src/domain/entities/recipe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
class RecipeModel with _$RecipeModel {
  const factory RecipeModel({
    required String id,
    required String title,
    required String description,
    required List<String> ingredients,
    required List<String> instructions,
    required NutritionModel nutrition,
    required MealTime mealTime,
    required int prepTime,
    required int cookTime,
    required int servings,
    String? imageUrl,
    List<String>? tags,
    @Default(false) bool isFavorite,
  }) = _RecipeModel;

  const RecipeModel._();

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);

  /// Convert from entity
  factory RecipeModel.fromEntity(Recipe entity) {
    return RecipeModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      ingredients: entity.ingredients,
      instructions: entity.instructions,
      nutrition: NutritionModel.fromEntity(entity.nutrition),
      mealTime: entity.mealTime,
      prepTime: entity.prepTime,
      cookTime: entity.cookTime,
      servings: entity.servings,
      imageUrl: entity.imageUrl,
      tags: entity.tags,
      isFavorite: entity.isFavorite,
    );
  }

  /// Convert to entity
  Recipe toEntity() {
    return Recipe(
      id: id,
      title: title,
      description: description,
      ingredients: ingredients,
      instructions: instructions,
      nutrition: nutrition.toEntity(),
      mealTime: mealTime,
      prepTime: prepTime,
      cookTime: cookTime,
      servings: servings,
      imageUrl: imageUrl,
      tags: tags,
      isFavorite: isFavorite,
    );
  }
}
