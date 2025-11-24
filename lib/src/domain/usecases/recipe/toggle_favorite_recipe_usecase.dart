import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/repositories/recipe_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleFavoriteRecipeUseCase {
  ToggleFavoriteRecipeUseCase(this._repository);

  final RecipeRepository _repository;

  Future<Either<Failure, void>> call(String recipeId) {
    return _repository.toggleFavorite(recipeId);
  }
}
