import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:fiteats/src/domain/repositories/workout_plan_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveWorkoutPlanUseCase {
  SaveWorkoutPlanUseCase(this._repository);

  final WorkoutPlanRepository _repository;

  Future<Either<Failure, void>> call(WorkoutPlan workoutPlan) {
    return _repository.saveWorkoutPlan(workoutPlan);
  }
}
