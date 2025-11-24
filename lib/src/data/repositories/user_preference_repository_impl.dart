import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/exceptions.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/data/datasources/local/hive_user_preference_local_datasource.dart';
import 'package:fiteats/src/data/models/user_preference_model.dart';
import 'package:fiteats/src/domain/entities/user_preference.dart';
import 'package:fiteats/src/domain/repositories/user_preference_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: UserPreferenceRepository)
class UserPreferenceRepositoryImpl implements UserPreferenceRepository {
  UserPreferenceRepositoryImpl(this._localDataSource);

  final HiveUserPreferenceLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, UserPreference>> getUserPreference(
    String userId,
  ) async {
    try {
      final model = await _localDataSource.getUserPreference(userId);

      if (model == null) {
        return const Left(
          Failure.cache(
            message: 'User preference not found',
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
  Future<Either<Failure, void>> saveUserPreference(
    UserPreference preference,
  ) async {
    try {
      final model = UserPreferenceModel.fromEntity(preference);
      await _localDataSource.saveUserPreference(model);
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
  Future<Either<Failure, void>> deleteUserPreference(String userId) async {
    try {
      await _localDataSource.deleteUserPreference(userId);
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
  Future<Either<Failure, List<UserPreference>>> getAllUserPreferences() async {
    try {
      final models = await _localDataSource.getAllUserPreferences();
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
}
