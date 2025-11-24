import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/repositories/shopping_list_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleShoppingItemUseCase {
  ToggleShoppingItemUseCase(this._repository);

  final ShoppingListRepository _repository;

  Future<Either<Failure, void>> call(String itemId) {
    return _repository.toggleChecked(itemId);
  }
}
