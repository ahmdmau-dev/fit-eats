import 'package:fiteats/src/data/models/recipe_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class HiveRecipeLocalDataSource {
  Future<void> saveRecipe(RecipeModel recipe);
  Future<RecipeModel?> getRecipe(String id);
  Future<void> deleteRecipe(String id);
  Future<List<RecipeModel>> getAllRecipes();
  Future<List<RecipeModel>> getFavoriteRecipes();
  Future<List<RecipeModel>> getRecipesByMealTime(String mealTime);
  Future<void> toggleFavorite(String id);
}

@LazySingleton(as: HiveRecipeLocalDataSource)
class HiveRecipeLocalDataSourceImpl implements HiveRecipeLocalDataSource {
  HiveRecipeLocalDataSourceImpl(this._box);

  final Box<dynamic> _box;
  static const String _keyPrefix = 'recipe_';

  String _getRecipeKey(String id) => '$_keyPrefix$id';

  @override
  Future<void> saveRecipe(RecipeModel recipe) async {
    final key = _getRecipeKey(recipe.id);
    await _box.put(key, recipe.toJson());
  }

  @override
  Future<RecipeModel?> getRecipe(String id) async {
    final key = _getRecipeKey(id);
    final data = _box.get(key);
    if (data == null) return null;

    return RecipeModel.fromJson(Map<String, dynamic>.from(data as Map));
  }

  @override
  Future<void> deleteRecipe(String id) async {
    final key = _getRecipeKey(id);
    await _box.delete(key);
  }

  @override
  Future<List<RecipeModel>> getAllRecipes() async {
    final allKeys = _box.keys.where((key) => key.toString().startsWith(_keyPrefix));
    final recipes = <RecipeModel>[];

    for (final key in allKeys) {
      final data = _box.get(key);
      if (data != null) {
        recipes.add(RecipeModel.fromJson(Map<String, dynamic>.from(data as Map)));
      }
    }

    return recipes;
  }

  @override
  Future<List<RecipeModel>> getFavoriteRecipes() async {
    final allRecipes = await getAllRecipes();
    return allRecipes.where((recipe) => recipe.isFavorite).toList();
  }

  @override
  Future<List<RecipeModel>> getRecipesByMealTime(String mealTime) async {
    final allRecipes = await getAllRecipes();
    return allRecipes
        .where((recipe) => recipe.mealTime.name == mealTime)
        .toList();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final recipe = await getRecipe(id);
    if (recipe != null) {
      final updatedRecipe = recipe.copyWith(isFavorite: !recipe.isFavorite);
      await saveRecipe(updatedRecipe);
    }
  }
}
