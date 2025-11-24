import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_item.freezed.dart';

/// Shopping list category enum
enum ShoppingCategory {
  produce,
  dairy,
  meat,
  seafood,
  bakery,
  pantry,
  frozen,
  beverages,
  snacks,
  other;

  String get label {
    switch (this) {
      case ShoppingCategory.produce:
        return 'Produce';
      case ShoppingCategory.dairy:
        return 'Dairy';
      case ShoppingCategory.meat:
        return 'Meat';
      case ShoppingCategory.seafood:
        return 'Seafood';
      case ShoppingCategory.bakery:
        return 'Bakery';
      case ShoppingCategory.pantry:
        return 'Pantry';
      case ShoppingCategory.frozen:
        return 'Frozen';
      case ShoppingCategory.beverages:
        return 'Beverages';
      case ShoppingCategory.snacks:
        return 'Snacks';
      case ShoppingCategory.other:
        return 'Other';
    }
  }
}

/// Shopping list item entity
@freezed
class ShoppingListItem with _$ShoppingListItem {
  const factory ShoppingListItem({
    required String id,
    required String userId,
    required String name,
    required ShoppingCategory category,
    required DateTime createdAt,
    String? quantity,
    String? unit,
    @Default(false) bool isChecked,
    String? recipeId,
    String? notes,
  }) = _ShoppingListItem;

  const ShoppingListItem._();

  /// Display text for quantity
  String get quantityDisplay {
    if (quantity == null) return '';
    if (unit == null) return quantity!;
    return '$quantity $unit';
  }
}
