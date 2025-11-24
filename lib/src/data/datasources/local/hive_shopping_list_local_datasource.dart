import 'package:fiteats/src/data/models/shopping_list_item_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

abstract class HiveShoppingListLocalDataSource {
  Future<void> saveShoppingListItem(ShoppingListItemModel item);
  Future<ShoppingListItemModel?> getShoppingListItem(String id);
  Future<void> deleteShoppingListItem(String id);
  Future<List<ShoppingListItemModel>> getAllShoppingListItems(String userId);
  Future<List<ShoppingListItemModel>> getShoppingListItemsByCategory(
    String userId,
    String category,
  );
  Future<List<ShoppingListItemModel>> getCheckedItems(String userId);
  Future<List<ShoppingListItemModel>> getUncheckedItems(String userId);
  Future<void> toggleChecked(String id);
  Future<void> clearCheckedItems(String userId);
}

@LazySingleton(as: HiveShoppingListLocalDataSource)
class HiveShoppingListLocalDataSourceImpl
    implements HiveShoppingListLocalDataSource {
  HiveShoppingListLocalDataSourceImpl(this._box);

  final Box<dynamic> _box;
  static const String _keyPrefix = 'shopping_list_item_';

  String _getItemKey(String id) => '$_keyPrefix$id';

  @override
  Future<void> saveShoppingListItem(ShoppingListItemModel item) async {
    final key = _getItemKey(item.id);
    await _box.put(key, item.toJson());
  }

  @override
  Future<ShoppingListItemModel?> getShoppingListItem(String id) async {
    final key = _getItemKey(id);
    final data = _box.get(key);
    if (data == null) return null;

    return ShoppingListItemModel.fromJson(
      Map<String, dynamic>.from(data as Map),
    );
  }

  @override
  Future<void> deleteShoppingListItem(String id) async {
    final key = _getItemKey(id);
    await _box.delete(key);
  }

  @override
  Future<List<ShoppingListItemModel>> getAllShoppingListItems(
    String userId,
  ) async {
    final allKeys =
        _box.keys.where((key) => key.toString().startsWith(_keyPrefix));
    final items = <ShoppingListItemModel>[];

    for (final key in allKeys) {
      final data = _box.get(key);
      if (data != null) {
        final item = ShoppingListItemModel.fromJson(
          Map<String, dynamic>.from(data as Map),
        );
        if (item.userId == userId) {
          items.add(item);
        }
      }
    }

    // Sort by creation date (most recent first)
    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return items;
  }

  @override
  Future<List<ShoppingListItemModel>> getShoppingListItemsByCategory(
    String userId,
    String category,
  ) async {
    final allItems = await getAllShoppingListItems(userId);
    return allItems.where((item) => item.category.name == category).toList();
  }

  @override
  Future<List<ShoppingListItemModel>> getCheckedItems(String userId) async {
    final allItems = await getAllShoppingListItems(userId);
    return allItems.where((item) => item.isChecked).toList();
  }

  @override
  Future<List<ShoppingListItemModel>> getUncheckedItems(String userId) async {
    final allItems = await getAllShoppingListItems(userId);
    return allItems.where((item) => !item.isChecked).toList();
  }

  @override
  Future<void> toggleChecked(String id) async {
    final item = await getShoppingListItem(id);
    if (item != null) {
      final updatedItem = item.copyWith(isChecked: !item.isChecked);
      await saveShoppingListItem(updatedItem);
    }
  }

  @override
  Future<void> clearCheckedItems(String userId) async {
    final checkedItems = await getCheckedItems(userId);
    for (final item in checkedItems) {
      await deleteShoppingListItem(item.id);
    }
  }
}
