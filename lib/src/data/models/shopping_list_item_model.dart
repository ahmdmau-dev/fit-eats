import 'package:fiteats/src/domain/entities/shopping_list_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_item_model.freezed.dart';
part 'shopping_list_item_model.g.dart';

@freezed
class ShoppingListItemModel with _$ShoppingListItemModel {
  const factory ShoppingListItemModel({
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
  }) = _ShoppingListItemModel;

  const ShoppingListItemModel._();

  factory ShoppingListItemModel.fromJson(Map<String, dynamic> json) =>
      _$ShoppingListItemModelFromJson(json);

  /// Convert from entity
  factory ShoppingListItemModel.fromEntity(ShoppingListItem entity) {
    return ShoppingListItemModel(
      id: entity.id,
      userId: entity.userId,
      name: entity.name,
      category: entity.category,
      createdAt: entity.createdAt,
      quantity: entity.quantity,
      unit: entity.unit,
      isChecked: entity.isChecked,
      recipeId: entity.recipeId,
      notes: entity.notes,
    );
  }

  /// Convert to entity
  ShoppingListItem toEntity() {
    return ShoppingListItem(
      id: id,
      userId: userId,
      name: name,
      category: category,
      createdAt: createdAt,
      quantity: quantity,
      unit: unit,
      isChecked: isChecked,
      recipeId: recipeId,
      notes: notes,
    );
  }
}
