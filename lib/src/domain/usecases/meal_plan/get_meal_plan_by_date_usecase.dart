import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:fiteats/src/domain/repositories/meal_plan_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetMealPlanByDateUseCase {
  GetMealPlanByDateUseCase(this._repository);

  final MealPlanRepository _repository;

  Future<Either<Failure, MealPlan?>> call(DateTime date) {
    return _repository.getMealPlanByDate(date);
  }
}
