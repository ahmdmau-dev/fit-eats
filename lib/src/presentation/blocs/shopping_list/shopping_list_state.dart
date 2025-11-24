import 'package:fiteats/src/domain/entities/shopping_list_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_state.freezed.dart';

@freezed
class ShoppingListState with _$ShoppingListState {
  const factory ShoppingListState.initial() = ShoppingListInitial;

  const factory ShoppingListState.loading() = ShoppingListLoading;

  const factory ShoppingListState.loaded(List<ShoppingListItem> items) =
      ShoppingListLoaded;

  const factory ShoppingListState.error(String message) = ShoppingListError;
}
