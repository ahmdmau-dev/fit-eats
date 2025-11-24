import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/exceptions.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/data/datasources/local/hive_meal_plan_local_datasource.dart';
import 'package:fiteats/src/data/models/meal_plan_model.dart';
import 'package:fiteats/src/domain/entities/meal_plan.dart';
import 'package:fiteats/src/domain/repositories/meal_plan_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MealPlanRepository)
class MealPlanRepositoryImpl implements MealPlanRepository {
  MealPlanRepositoryImpl(this._localDataSource);

  final HiveMealPlanLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, MealPlan>> getMealPlan(String id) async {
    try {
      final model = await _localDataSource.getMealPlan(id);

      if (model == null) {
        return const Left(Failure.cache(message: 'Meal plan not found'));
      }

      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MealPlan?>> getMealPlanByDate(DateTime date) async {
    try {
      final model = await _localDataSource.getMealPlanByDate(date);

      if (model == null) {
        return const Right(null);
      }

      return Right(model.toEntity());
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveMealPlan(MealPlan mealPlan) async {
    try {
      final model = MealPlanModel.fromEntity(mealPlan);
      await _localDataSource.saveMealPlan(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMealPlan(String id) async {
    try {
      await _localDataSource.deleteMealPlan(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MealPlan>>> getAllMealPlans(String userId) async {
    try {
      final models = await _localDataSource.getAllMealPlans();

      // Filter by userId
      final filtered = models.where((model) => model.userId == userId).toList();

      final entities = filtered.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MealPlan>>> getMealPlansForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final models = await _localDataSource.getMealPlansForDateRange(
        startDate,
        endDate,
      );
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on CacheException catch (e) {
      return Left(Failure.cache(message: e.message));
    } catch (e) {
      return Left(Failure.unexpected(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, MealPlan>> generateMealPlan({
    required String userId,
    required DateTime date,
    required int calorieTarget,
    required List<String> dietaryPreferences,
    required List<String> allergies,
  }) async {
    // TODO: Implement AI-powered meal plan generation
    // This will be implemented in Phase 5 when we add AI service integration
    return const Left(
      Failure.notImplemented(
        message: 'AI meal plan generation not implemented yet',
      ),
    );
  }
}
