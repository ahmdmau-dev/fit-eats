import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/shopping_list_item.dart';
import 'package:fiteats/src/domain/repositories/shopping_list_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetShoppingListItemsUseCase {
  GetShoppingListItemsUseCase(this._repository);

  final ShoppingListRepository _repository;

  Future<Either<Failure, List<ShoppingListItem>>> call(String userId) {
    return _repository.getAllShoppingListItems(userId);
  }
}
