import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/constants/enums.dart';
import 'package:fiteats/src/core/errors/exceptions.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/data/datasources/local/hive_workout_plan_local_datasource.dart';
import 'package:fiteats/src/data/models/workout_plan_model.dart';
import 'package:fiteats/src/domain/entities/workout_plan.dart';
import 'package:fiteats/src/domain/repositories/workout_plan_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WorkoutPlanRepository)
class WorkoutPlanRepositoryImpl implements WorkoutPlanRepository {
  WorkoutPlanRepositoryImpl(this._localDataSource);

  final HiveWorkoutPlanLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, WorkoutPlan>> getWorkoutPlan(String id) async {
    try {
      final model = await _localDataSource.getWorkoutPlan(id);

      if (model == null) {
        return Left(
          Failure.cache(
            message: 'Workout plan not found',
          ),
        );
      }

      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan?>> getWorkoutPlanByDate(
    DateTime date,
  ) async {
    try {
      final model = await _localDataSource.getWorkoutPlanByDate(date);

      if (model == null) {
        return const Right(null);
      }

      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> saveWorkoutPlan(WorkoutPlan workoutPlan) async {
    try {
      final model = WorkoutPlanModel.fromEntity(workoutPlan);
      await _localDataSource.saveWorkoutPlan(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> deleteWorkoutPlan(String id) async {
    try {
      await _localDataSource.deleteWorkoutPlan(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<WorkoutPlan>>> getAllWorkoutPlans(
    String userId,
  ) async {
    try {
      final models = await _localDataSource.getAllWorkoutPlans();

      // Filter by userId
      final filtered =
          models.where((model) => model.userId == userId).toList();

      final entities = filtered.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<WorkoutPlan>>> getWorkoutPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final models = await _localDataSource.getWorkoutPlansForDateRange(
        startDate,
        endDate,
      );
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<WorkoutPlan>>> getCompletedWorkoutPlans(
    String userId,
  ) async {
    try {
      final models = await _localDataSource.getCompletedWorkoutPlans();

      // Filter by userId
      final filtered =
          models.where((model) => model.userId == userId).toList();

      final entities = filtered.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> toggleCompletion(String id) async {
    try {
      await _localDataSource.toggleCompletion(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        Failure.cache(
          message: e.message,
        ),
      );
    } catch (e) {
      return Left(
        Failure.unexpected(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, WorkoutPlan>> generateWorkoutPlan({
    required String userId,
    required DateTime date,
    required WorkoutLevel level,
    required WorkoutType type,
    required int duration,
  }) async {
    // TODO: Implement AI-powered workout plan generation
    // This will be implemented in Phase 5 when we add AI service integration
    return Left(
      Failure.notImplemented(
        message: 'AI workout plan generation not implemented yet',
      ),
    );
  }
}
