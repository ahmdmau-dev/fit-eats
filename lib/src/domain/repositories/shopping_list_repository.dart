import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/shopping_list_item.dart';

abstract class ShoppingListRepository {
  /// Get shopping list item by ID
  Future<Either<Failure, ShoppingListItem>> getShoppingListItem(String id);

  /// Save or update shopping list item
  Future<Either<Failure, void>> saveShoppingListItem(ShoppingListItem item);

  /// Delete shopping list item
  Future<Either<Failure, void>> deleteShoppingListItem(String id);

  /// Get all shopping list items for a user
  Future<Either<Failure, List<ShoppingListItem>>> getAllShoppingListItems(
    String userId,
  );

  /// Get shopping list items by category
  Future<Either<Failure, List<ShoppingListItem>>> getShoppingListItemsByCategory(
    String userId,
    ShoppingCategory category,
  );

  /// Get checked items
  Future<Either<Failure, List<ShoppingListItem>>> getCheckedItems(
    String userId,
  );

  /// Get unchecked items
  Future<Either<Failure, List<ShoppingListItem>>> getUncheckedItems(
    String userId,
  );

  /// Toggle item checked status
  Future<Either<Failure, void>> toggleChecked(String id);

  /// Clear all checked items
  Future<Either<Failure, void>> clearCheckedItems(String userId);

  /// Add items from meal plan
  Future<Either<Failure, void>> addItemsFromMealPlan(
    String userId,
    String mealPlanId,
  );
}
