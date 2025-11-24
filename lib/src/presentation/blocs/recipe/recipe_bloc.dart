import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/usecases/recipe/get_all_recipes_usecase.dart';
import 'package:fiteats/src/domain/usecases/recipe/get_favorite_recipes_usecase.dart';
import 'package:fiteats/src/domain/usecases/recipe/search_recipes_usecase.dart';
import 'package:fiteats/src/domain/usecases/recipe/toggle_favorite_recipe_usecase.dart';
import 'package:fiteats/src/presentation/blocs/recipe/recipe_event.dart';
import 'package:fiteats/src/presentation/blocs/recipe/recipe_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  RecipeBloc(
    this._getAllRecipesUseCase,
    this._getFavoriteRecipesUseCase,
    this._searchRecipesUseCase,
    this._toggleFavoriteRecipeUseCase,
  ) : super(const RecipeState.initial()) {
    on<LoadAllRecipesEvent>(_onLoadAllRecipes);
    on<LoadFavoriteRecipesEvent>(_onLoadFavoriteRecipes);
    on<SearchRecipesEvent>(_onSearchRecipes);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  final GetAllRecipesUseCase _getAllRecipesUseCase;
  final GetFavoriteRecipesUseCase _getFavoriteRecipesUseCase;
  final SearchRecipesUseCase _searchRecipesUseCase;
  final ToggleFavoriteRecipeUseCase _toggleFavoriteRecipeUseCase;

  Future<void> _onLoadAllRecipes(
    LoadAllRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeState.loading());

    final result = await _getAllRecipesUseCase();

    result.fold(
      (failure) => emit(RecipeState.error(failure.userMessage)),
      (recipes) => emit(RecipeState.loaded(recipes)),
    );
  }

  Future<void> _onLoadFavoriteRecipes(
    LoadFavoriteRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeState.loading());

    final result = await _getFavoriteRecipesUseCase();

    result.fold(
      (failure) => emit(RecipeState.error(failure.userMessage)),
      (recipes) => emit(RecipeState.loaded(recipes)),
    );
  }

  Future<void> _onSearchRecipes(
    SearchRecipesEvent event,
    Emitter<RecipeState> emit,
  ) async {
    emit(const RecipeState.loading());

    final result = await _searchRecipesUseCase(event.keyword);

    result.fold(
      (failure) => emit(RecipeState.error(failure.userMessage)),
      (recipes) => emit(RecipeState.loaded(recipes)),
    );
  }

  Future<void> _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<RecipeState> emit,
  ) async {
    final result = await _toggleFavoriteRecipeUseCase(event.recipeId);

    result.fold(
      (failure) => emit(RecipeState.error(failure.userMessage)),
      (_) {
        // Reload recipes after toggling favorite
        add(const RecipeEvent.loadAllRecipes());
      },
    );
  }
}
