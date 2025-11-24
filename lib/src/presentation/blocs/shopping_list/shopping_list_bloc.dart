import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/usecases/shopping_list/add_shopping_item_usecase.dart';
import 'package:fiteats/src/domain/usecases/shopping_list/clear_checked_items_usecase.dart';
import 'package:fiteats/src/domain/usecases/shopping_list/get_shopping_list_items_usecase.dart';
import 'package:fiteats/src/domain/usecases/shopping_list/toggle_shopping_item_usecase.dart';
import 'package:fiteats/src/presentation/blocs/shopping_list/shopping_list_event.dart';
import 'package:fiteats/src/presentation/blocs/shopping_list/shopping_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc(
    this._getShoppingListItemsUseCase,
    this._addShoppingItemUseCase,
    this._toggleShoppingItemUseCase,
    this._clearCheckedItemsUseCase,
  ) : super(const ShoppingListState.initial()) {
    on<LoadShoppingListEvent>(_onLoadShoppingList);
    on<AddItemEvent>(_onAddItem);
    on<ToggleItemEvent>(_onToggleItem);
    on<ClearCheckedItemsEvent>(_onClearCheckedItems);
  }

  final GetShoppingListItemsUseCase _getShoppingListItemsUseCase;
  final AddShoppingItemUseCase _addShoppingItemUseCase;
  final ToggleShoppingItemUseCase _toggleShoppingItemUseCase;
  final ClearCheckedItemsUseCase _clearCheckedItemsUseCase;

  Future<void> _onLoadShoppingList(
    LoadShoppingListEvent event,
    Emitter<ShoppingListState> emit,
  ) async {
    emit(const ShoppingListState.loading());

    final result = await _getShoppingListItemsUseCase(event.userId);

    result.fold(
      (failure) => emit(ShoppingListState.error(failure.userMessage)),
      (items) => emit(ShoppingListState.loaded(items)),
    );
  }

  Future<void> _onAddItem(
    AddItemEvent event,
    Emitter<ShoppingListState> emit,
  ) async {
    final result = await _addShoppingItemUseCase(event.item);

    result.fold(
      (failure) => emit(ShoppingListState.error(failure.userMessage)),
      (_) {
        // Reload shopping list after adding item
        add(ShoppingListEvent.loadShoppingList(event.item.userId));
      },
    );
  }

  Future<void> _onToggleItem(
    ToggleItemEvent event,
    Emitter<ShoppingListState> emit,
  ) async {
    final result = await _toggleShoppingItemUseCase(event.itemId);

    result.fold(
      (failure) => emit(ShoppingListState.error(failure.userMessage)),
      (_) {
        // Update the current state by toggling the item
        state.maybeWhen(
          loaded: (items) {
            final updatedItems = items.map((item) {
              if (item.id == event.itemId) {
                return item.copyWith(isChecked: !item.isChecked);
              }
              return item;
            }).toList();
            emit(ShoppingListState.loaded(updatedItems));
          },
          orElse: () {},
        );
      },
    );
  }

  Future<void> _onClearCheckedItems(
    ClearCheckedItemsEvent event,
    Emitter<ShoppingListState> emit,
  ) async {
    final result = await _clearCheckedItemsUseCase(event.userId);

    result.fold(
      (failure) => emit(ShoppingListState.error(failure.userMessage)),
      (_) {
        // Reload shopping list after clearing checked items
        add(ShoppingListEvent.loadShoppingList(event.userId));
      },
    );
  }
}
