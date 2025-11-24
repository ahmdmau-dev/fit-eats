import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/user_preference.dart';

abstract class UserPreferenceRepository {
  /// Get user preference by user ID
  Future<Either<Failure, UserPreference>> getUserPreference(String userId);

  /// Save or update user preference
  Future<Either<Failure, void>> saveUserPreference(UserPreference preference);

  /// Delete user preference
  Future<Either<Failure, void>> deleteUserPreference(String userId);

  /// Get all user preferences (mainly for admin purposes)
  Future<Either<Failure, List<UserPreference>>> getAllUserPreferences();
}
