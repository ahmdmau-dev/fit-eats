import 'package:fiteats/src/domain/entities/recipe.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_state.freezed.dart';

@freezed
class RecipeState with _$RecipeState {
  const factory RecipeState.initial() = RecipeInitial;

  const factory RecipeState.loading() = RecipeLoading;

  const factory RecipeState.loaded(List<Recipe> recipes) = RecipeLoaded;

  const factory RecipeState.error(String message) = RecipeError;
}
