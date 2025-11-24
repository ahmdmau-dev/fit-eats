import 'package:dartz/dartz.dart';
import 'package:fiteats/src/core/errors/failures.dart';
import 'package:fiteats/src/domain/entities/user_preference.dart';
import 'package:fiteats/src/domain/repositories/user_preference_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveUserPreferenceUseCase {
  SaveUserPreferenceUseCase(this._repository);

  final UserPreferenceRepository _repository;

  Future<Either<Failure, void>> call(UserPreference preference) {
    return _repository.saveUserPreference(preference);
  }
}
