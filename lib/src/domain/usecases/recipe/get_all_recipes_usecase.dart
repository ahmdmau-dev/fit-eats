import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/recipe.dart';
import 'package:fiteats/src/domain/repositories/recipe_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllRecipesUseCase {
  GetAllRecipesUseCase(this._repository);

  final RecipeRepository _repository;

  Future<Either<Failure, List<Recipe>>> call() {
    return _repository.getAllRecipes();
  }
}
