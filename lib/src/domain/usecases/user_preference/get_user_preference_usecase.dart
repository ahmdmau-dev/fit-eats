import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/user_preference.dart';
import 'package:fiteats/src/domain/repositories/user_preference_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetUserPreferenceUseCase {
  GetUserPreferenceUseCase(this._repository);

  final UserPreferenceRepository _repository;

  Future<Either<Failure, UserPreference>> call(String userId) {
    return _repository.getUserPreference(userId);
  }
}
