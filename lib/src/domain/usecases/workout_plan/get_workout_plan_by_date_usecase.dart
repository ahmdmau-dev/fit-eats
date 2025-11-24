import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:fiteats/src/domain/repositories/workout_plan_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetWorkoutPlanByDateUseCase {
  GetWorkoutPlanByDateUseCase(this._repository);

  final WorkoutPlanRepository _repository;

  Future<Either<Failure, WorkoutPlan?>> call(DateTime date) {
    return _repository.getWorkoutPlanByDate(date);
  }
}
