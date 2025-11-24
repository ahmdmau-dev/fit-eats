import 'package:fiteats/src/domain/entities/shopping_list_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_event.freezed.dart';

@freezed
class ShoppingListEvent with _$ShoppingListEvent {
  const factory ShoppingListEvent.loadShoppingList(String userId) =
      LoadShoppingListEvent;

  const factory ShoppingListEvent.addItem(ShoppingListItem item) = AddItemEvent;

  const factory ShoppingListEvent.toggleItem(String itemId) = ToggleItemEvent;

  const factory ShoppingListEvent.clearCheckedItems(String userId) =
      ClearCheckedItemsEvent;
}
