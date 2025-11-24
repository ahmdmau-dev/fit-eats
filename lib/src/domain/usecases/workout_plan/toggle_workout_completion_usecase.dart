import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/repositories/workout_plan_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ToggleWorkoutCompletionUseCase {
  ToggleWorkoutCompletionUseCase(this._repository);

  final WorkoutPlanRepository _repository;

  Future<Either<Failure, void>> call(String workoutPlanId) {
    return _repository.toggleCompletion(workoutPlanId);
  }
}
