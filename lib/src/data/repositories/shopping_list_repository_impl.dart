import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/exceptions.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/data/datasources/local/hive_shopping_list_local_datasource.dart';
import 'package:fiteats/src/data/models/shopping_list_item_model.dart';
import 'package:fiteats/src/domain/entities/shopping_list_item.dart';
import 'package:fiteats/src/domain/repositories/shopping_list_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ShoppingListRepository)
class ShoppingListRepositoryImpl implements ShoppingListRepository {
  ShoppingListRepositoryImpl(this._localDataSource);

  final HiveShoppingListLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, ShoppingListItem>> getShoppingListItem(
    String id,
  ) async {
    try {
      final model = await _localDataSource.getShoppingListItem(id);

      if (model == null) {
        return Left(
          Failure.cache(
            message: 'Shopping list item not found',
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
  Future<Either<Failure, void>> saveShoppingListItem(
    ShoppingListItem item,
  ) async {
    try {
      final model = ShoppingListItemModel.fromEntity(item);
      await _localDataSource.saveShoppingListItem(model);
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
  Future<Either<Failure, void>> deleteShoppingListItem(String id) async {
    try {
      await _localDataSource.deleteShoppingListItem(id);
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
  Future<Either<Failure, List<ShoppingListItem>>> getAllShoppingListItems(
    String userId,
  ) async {
    try {
      final models = await _localDataSource.getAllShoppingListItems(userId);
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
  Future<Either<Failure, List<ShoppingListItem>>>
      getShoppingListItemsByCategory(
    String userId,
    ShoppingCategory category,
  ) async {
    try {
      final models = await _localDataSource.getShoppingListItemsByCategory(
        userId,
        category.name,
      );
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
  Future<Either<Failure, List<ShoppingListItem>>> getCheckedItems(
    String userId,
  ) async {
    try {
      final models = await _localDataSource.getCheckedItems(userId);
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
  Future<Either<Failure, List<ShoppingListItem>>> getUncheckedItems(
    String userId,
  ) async {
    try {
      final models = await _localDataSource.getUncheckedItems(userId);
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
  Future<Either<Failure, void>> toggleChecked(String id) async {
    try {
      await _localDataSource.toggleChecked(id);
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
  Future<Either<Failure, void>> clearCheckedItems(String userId) async {
    try {
      await _localDataSource.clearCheckedItems(userId);
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
  Future<Either<Failure, void>> addItemsFromMealPlan(
    String userId,
    String mealPlanId,
  ) async {
    // TODO: Implement adding items from meal plan
    // This will be implemented when we have the meal plan to shopping list conversion logic
    return Left(
      Failure.notImplemented(
        message: 'Add items from meal plan not implemented yet',
      ),
    );
  }
}
