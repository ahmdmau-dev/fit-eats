import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_event.freezed.dart';

@freezed
class RecipeEvent with _$RecipeEvent {
  const factory RecipeEvent.loadAllRecipes() = LoadAllRecipesEvent;

  const factory RecipeEvent.loadFavoriteRecipes() = LoadFavoriteRecipesEvent;

  const factory RecipeEvent.searchRecipes(String keyword) = SearchRecipesEvent;

  const factory RecipeEvent.toggleFavorite(String recipeId) =
      ToggleFavoriteEvent;

  const factory RecipeEvent.filterByMealTime(String mealTime) =
      FilterByMealTimeEvent;
}
