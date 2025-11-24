import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/core/errors/exceptions.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/data/datasources/local/hive_recipe_local_datasource.dart';
import 'package:fiteats/src/data/models/recipe_model.dart';
import 'package:fiteats/src/domain/entities/recipe.dart';
import 'package:fiteats/src/domain/repositories/recipe_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: RecipeRepository)
class RecipeRepositoryImpl implements RecipeRepository {
  RecipeRepositoryImpl(this._localDataSource);

  final HiveRecipeLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, Recipe>> getRecipe(String id) async {
    try {
      final model = await _localDataSource.getRecipe(id);

      if (model == null) {
        return Left(
          Failure.cache(
            message: 'Recipe not found',
          ),
        );
      }

      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveRecipe(Recipe recipe) async {
    try {
      final model = RecipeModel.fromEntity(recipe);
      await _localDataSource.saveRecipe(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecipe(String id) async {
    try {
      await _localDataSource.deleteRecipe(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getAllRecipes() async {
    try {
      final models = await _localDataSource.getAllRecipes();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getFavoriteRecipes() async {
    try {
      final models = await _localDataSource.getFavoriteRecipes();
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByMealTime(
    MealTime mealTime,
  ) async {
    try {
      final models = await _localDataSource.getRecipesByMealTime(mealTime.name);
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String id) async {
    try {
      await _localDataSource.toggleFavorite(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipes(String keyword) async {
    try {
      final models = await _localDataSource.getAllRecipes();

      // Search by title, description, or ingredients
      final filtered = models.where((recipe) {
        final lowerKeyword = keyword.toLowerCase();
        final titleMatch = recipe.title.toLowerCase().contains(lowerKeyword);
        final descMatch =
            recipe.description.toLowerCase().contains(lowerKeyword);
        final ingredientsMatch = recipe.ingredients.any(
          (ingredient) => ingredient.toLowerCase().contains(lowerKeyword),
        );

        return titleMatch || descMatch || ingredientsMatch;
      }).toList();

      final entities = filtered.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<Recipe>>> getRecipesByDiet(
    List<String> tags,
  ) async {
    try {
      final models = await _localDataSource.getAllRecipes();

      // Filter recipes that have at least one matching tag
      final filtered = models.where((recipe) {
        if (recipe.tags == null || recipe.tags!.isEmpty) return false;

        return tags.any(
          (tag) => recipe.tags!.any(
            (recipeTag) =>
                recipeTag.toLowerCase() == tag.toLowerCase(),
          ),
        );
      }).toList();

      final entities = filtered.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }
}
