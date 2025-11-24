import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/recipe.dart';

abstract class RecipeRepository {
  /// Get recipe by ID
  Future<Either<Failure, Recipe>> getRecipe(String id);

  /// Save or update recipe
  Future<Either<Failure, void>> saveRecipe(Recipe recipe);

  /// Delete recipe
  Future<Either<Failure, void>> deleteRecipe(String id);

  /// Get all recipes
  Future<Either<Failure, List<Recipe>>> getAllRecipes();

  /// Get favorite recipes
  Future<Either<Failure, List<Recipe>>> getFavoriteRecipes();

  /// Get recipes by meal time
  Future<Either<Failure, List<Recipe>>> getRecipesByMealTime(MealTime mealTime);

  /// Toggle recipe favorite status
  Future<Either<Failure, void>> toggleFavorite(String id);

  /// Search recipes by keyword
  Future<Either<Failure, List<Recipe>>> searchRecipes(String keyword);

  /// Get recipes by dietary preferences
  Future<Either<Failure, List<Recipe>>> getRecipesByDiet(List<String> tags);
}
